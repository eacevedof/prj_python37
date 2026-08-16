from typing import final, Self, Any

from ddd.outlook.infrastructure.repositories.abstract_outlook_graph_repository import (
    AbstractOutlookGraphRepository,
)


@final
class MessagesReaderGraphRepository(AbstractOutlookGraphRepository):
    """Repository for reading Outlook mailbox messages using Microsoft Graph API."""

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def list_messages(
        self,
        mailbox: str,
        folder: str | None = None,
        top: int = 25,
        unread_only: bool = False,
        search: str | None = None,
    ) -> list[dict[str, Any]]:
        """List messages from a mailbox (optionally within a mail folder).

        Args:
            mailbox: User principal name or id of the mailbox.
            folder: Optional mail folder (e.g. 'inbox') to scope the listing.
            top: Maximum number of messages to return.
            unread_only: If True, only return unread messages.
            search: Optional full-text search query (KQL) over the messages.

        Returns:
            List of raw message metadata dictionaries.

        Raises:
            OutlookException: If the API request fails.
        """
        url = f"{self._graph_base_url}/users/{mailbox}"
        if folder:
            url = f"{url}/mailFolders/{folder}"
        url = f"{url}/messages"

        select = "$select=id,subject,from,receivedDateTime,hasAttachments,isRead,bodyPreview"
        extra_headers: dict[str, str] | None = None

        if search:
            # Graph forbids combining $search with $orderby/$filter on messages.
            querystring = f'$top={top}&$search="{search}"&{select}'
            extra_headers = {"ConsistencyLevel": "eventual"}
        else:
            querystring = f"$top={top}&$orderby=receivedDateTime desc&{select}"
            if unread_only:
                querystring = f"{querystring}&$filter=isRead eq false"

        url = f"{url}?{querystring}"

        result = await self._request("GET", url, extra_headers=extra_headers)
        if result is None:
            return []
        return result.get("value", [])

    async def get_message(
        self, mailbox: str, message_id: str
    ) -> dict[str, Any] | None:
        """Get a single message (with body) from a mailbox.

        Args:
            mailbox: User principal name or id of the mailbox.
            message_id: Graph message id.

        Returns:
            Raw message dict, or None if not found.

        Raises:
            OutlookException: If the API request fails.
        """
        url = (
            f"{self._graph_base_url}/users/{mailbox}/messages/{message_id}"
            "?$select=id,subject,from,toRecipients,receivedDateTime,hasAttachments,body"
        )
        return await self._request("GET", url)

    async def list_attachments(
        self, mailbox: str, message_id: str
    ) -> list[dict[str, Any]]:
        """List attachments metadata for a message.

        Args:
            mailbox: User principal name or id of the mailbox.
            message_id: Graph message id.

        Returns:
            List of raw attachment metadata dictionaries.

        Raises:
            OutlookException: If the API request fails.
        """
        url = (
            f"{self._graph_base_url}/users/{mailbox}/messages/{message_id}/attachments"
            "?$select=id,name,contentType,size"
        )
        result = await self._request("GET", url)
        if result is None:
            return []
        return result.get("value", [])

    async def get_attachment(
        self, mailbox: str, message_id: str, attachment_id: str
    ) -> dict[str, Any] | None:
        """Get a single attachment (with inline content) from a message.

        Args:
            mailbox: User principal name or id of the mailbox.
            message_id: Graph message id.
            attachment_id: Graph attachment id.

        Returns:
            Raw attachment dict (incl. id, name, contentType, size, contentBytes),
            or None if not found.

        Raises:
            OutlookException: If the API request fails.
        """
        url = (
            f"{self._graph_base_url}/users/{mailbox}/messages/{message_id}"
            f"/attachments/{attachment_id}"
        )
        return await self._request("GET", url)
