import os
from dotenv import load_dotenv
import paramiko
from watchdog.observers import Observer
from watchdog.events import FileSystemEventHandler

load_dotenv()

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

    def upload_file(self, local_path):
        remote_file_path = os.path.join(self.remote_path, os.path.basename(local_path))
        self.sftp_client.put(local_path, remote_file_path)
        print(f"Uploaded {local_path} to {remote_file_path}")

def setup_sftp_client(hostname, port, username, password):
    transport = paramiko.Transport((hostname, port))
    transport.connect(username=username, password=password)
    sftp_client = paramiko.SFTPClient.from_transport(transport)
    return sftp_client

def main():
    hostname = os.getenv("hostname")
    port = 22
    username = os.getenv("username")
    password = os.getenv("password")
    remote_path = os.getenv("remote_path")

    sftp_client = setup_sftp_client(hostname, port, username, password)

    event_handler = SFTPHandler(sftp_client, remote_path)
    observer = Observer()
    observer.schedule(event_handler, path='.', recursive=True)
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