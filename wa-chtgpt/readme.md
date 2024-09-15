# python
- https://github.com/openai/openai-python/blob/main/api.md

# chatgpt api keys:
  - https://platform.openai.com/api-keys
  - https://platform.openai.com/settings/organization/billing/overview
  - https://platform.openai.com/docs/overview

# videos:
  - [vid 1 - https://www.youtube.com/watch?v=c77so_bKXhQ](https://www.youtube.com/watch?v=c77so_bKXhQ)
  - [vid 2 - https://www.youtube.com/watch?v=hNE2WPtn54A](https://www.youtube.com/watch?v=hNE2WPtn54A)
  - 

# facebook:
  - [https://developers.facebook.com/](https://developers.facebook.com/)
  - https://business.facebook.com/

```commandline
curl -i -X POST https://graph.facebook.com/v20.0/1076378991030422/messages \
-H 'Authorization: Bearer EAAFZCoM5eKPwBO2RLqG03WZBCgFowotttozU5xqIuuHtHumttbUmGxTLfX4yH0wrM05crm6iqZARNrZCbsh5yINtMZA1rrdfSTQJEZBJUPzVmJrlZAcnMBX5ysp3eb5Guc4Wn7WqzZCgHV8mNTlpJabQRROxCKfpflfxi5ji4PqteKXRfWVts5de2qvPqHkoSLp47N95NmX4TPdMw9iZCbxopUu12MMJhaFDZBr8kZD' \
-H 'Content-Type: application/json' \
-d '{
  "messaging_product": "whatsapp",
  "to": "35629160706",
  "type": "template",
  "template": {
    "name": "hello_world",
    "language": {
      "code": "en_US"
    }
  }
}'
```