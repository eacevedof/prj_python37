import os
import time

from dotenv import load_dotenv
import paramiko
from watchdog.observers import Observer
from watchdog.events import FileSystemEventHandler

load_dotenv()

def pr(text):
    pr(f"{time.strftime('%Y-%m-%d %H:%M:%S')} - {text}")

def get_sftp_client():
    hostname = os.getenv("SFTP_HOST")
    port = int(os.getenv("SFTP_PORT"))
    username = os.getenv("SFTP_USERNAME")
    password = os.getenv("SFTP_PASSWORD")

    transport = paramiko.Transport((hostname, port))
    transport.connect(username=username, password=password)

    sftp_client = paramiko.SFTPClient.from_transport(transport)
    return sftp_client

class SFTPHandler(FileSystemEventHandler):
    def __init__(self, sftp_client, remote_path):
        self.sftp_client = sftp_client
        self.remote_path = remote_path

    def on_modified(self, event):
        if not event.is_directory:
            self.upload_file(event.src_path)

    def on_created(self, event):
        if not event.is_directory:
            self.upload_file(event.src_path)

    def upload_file(self, upload_path):
        # si es el fichero temporal se salta
        if "~" in upload_path:
            return

        time.sleep(1)

        pr(f"upload_path: {upload_path}")
        pr(f"remote_path: {self.remote_path}")
        base_name = os.path.basename(upload_path)
        pr(f"base_name: {base_name}")

        remote_file_path = f"./{self.remote_path}/{base_name}"
        pr(f"remote_file_path: {remote_file_path}")

        self.sftp_client.put(upload_path, remote_file_path)
        pr(f"Uploaded {upload_path} to {remote_file_path}")


def main():
    sftp_client = get_sftp_client()

    remote_path = os.getenv("PATH_REMOTE_FOLDER")
    pr(f"remote_path: {remote_path}")
    event_handler = SFTPHandler(sftp_client, remote_path)

    observer = Observer()
    local_path = os.getenv("PATH_LOCAL_FOLDER")
    local_path = os.path.realpath(local_path)
    pr(f"local_path: {local_path}")
    observer.schedule(event_handler, path=local_path, recursive=True)

    observer.start()

    try:
        while True:
            pass
    except KeyboardInterrupt:
        observer.stop()

    observer.join()
    sftp_client.close()

if __name__ == "__main__":
    main()