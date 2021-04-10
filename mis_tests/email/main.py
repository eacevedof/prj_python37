from typing import List


def get_gmail_login() -> dict:
    return {
        "user": "some-from@gmail.com",
        "pwd": ":)Abcd1234"
    }


def get_cc_recipients() -> List[str]:
    return [
        "to-email-1@gmail.com",
        "to-email-2@yahoo.es",
    ]


def get_bcc_recipients() -> List[str]:
    return [
        "to-email-bcc@hotmail.com"
    ]


def get_attachments() -> List[str]:
    return [
        "./example-1.txt",
        "./example-2.txt"
    ]


def get_smtpssl_object():
    import smtplib
    access = get_gmail_login()
    server_ssl = smtplib.SMTP_SSL("smtp.gmail.com", 465)
    server_ssl.ehlo()
    server_ssl.login(access["user"], access["pwd"])
    return server_ssl


def get_html_template() -> str:
    html= """
    <html>
    <head> 
    <style>
    .body-email {
        margin:0;
        padding:0;
    }
    .img {
        margiin:0;
        padding:0;
        width: 350px;
        height: auto; 
    }
    .table-email {
        width: 100%;
        border: 1px solid #FEAB52;
        border-spacing: 10px;
        border-collapse: separate;
    }
    .p {
        margin:0;
        padding: 14px;
        text-align: justify;
        color: white;
        font-size: 15px;
        background-color: #FE9A3E;
    }
    .td { text-align: center; }   
    .h1 {
        text-decoration: underline;
    }
    </style>
    </head>
    <body class="body-email">
    <center> 
    <table class="table-email">
    <tr>
    <td class="td">
        <img src="https://resources.theframework.es/eduardoaf.com/20200906/095050-logo-eduardoafcom_500.png" class="img"/>
        <h1 class="h1"> Example H1 </h1>
        <p class="p">
            Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical 
            Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at 
            Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a 
            Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the 
            undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of "de Finibus Bonorum et Malorum" 
            (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, 
            very popular during the Renaissance. The first line of Lorem Ipsum, "Lorem ipsum dolor sit amet..", 
            comes from a line in section 1.10.32.
        </p>
    </td>
    </tr>    
    </table>
    </center> 
    </body>
    </html>
    """
    return html


def send_email_html(html="") -> None:
    from pathlib import Path
    from email.mime.multipart import MIMEMultipart
    from email.mime.text import MIMEText
    from email.mime.base import MIMEBase
    from email import encoders

    # MIME: Multipurpose Internet Mail Extensions. Mp3, Mid, mpeg, mov, nws etc
    #the correct MIME type is multipart/alternative.
    mime_obj = MIMEMultipart("mixed")

    subject = "This is an email subject from Python (example 1)"
    mime_obj["Subject"] = subject

    #mime_obj["From"] = "loquesea@mimail.com" no tiene ningún efecto

    # esto podría ir en blanco y llegaría pero el cliente de correo no mostraría nada en destinatarios
    # el o los receptores es decir irian como Bcc
    mime_obj["To"] = ", ".join(get_cc_recipients())

    plain_text = "This is a plain text example"
    mime_plain = MIMEText(plain_text, "plain")
    mime_html = MIMEText(html, "html")

    mime_obj.attach(mime_html)
    mime_obj.attach(mime_plain)

    smtp_obj = get_smtpssl_object()
    smtp_obj.set_debuglevel(1)

    for path in get_attachments():
        part = MIMEBase('application', "octet-stream")
        with open(path, 'rb') as file:
            part.set_payload(file.read())

        encoders.encode_base64(part)
        filename = Path(path).name
        part.add_header('Content-Disposition',f'attachment; filename="{filename}"')
        mime_obj.attach(part)

    smtp_obj.sendmail(
        #si esto se deja en blanco también se envía. No da error pero llega a SPAM.
        #No es necesario que coincida con el email de la cuenta de gmail
        "anyaccount@somedomain.local",
        get_cc_recipients()+get_bcc_recipients(),
        mime_obj.as_string()
    )
    smtp_obj.close()


if __name__ == "__main__":
    html = get_html_template()
    send_email_html(html)
