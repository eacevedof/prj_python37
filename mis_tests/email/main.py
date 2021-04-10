from typing import List



def get_smtpssl_object():
    import smtplib
    access = get_gmail_access()
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

def send_email_html(html=""):
    from email.mime.multipart import MIMEMultipart
    from email.mime.text import MIMEText

    # MIME: Multipurpose Internet Mail Extensions. Mp3, Mid, mpeg, mov, nws etc
    #the correct MIME type is multipart/alternative.
    mime_obj = MIMEMultipart("alternative")

    subject = "This is an email subject from Python (example 1)"
    mime_obj["Subject"] = subject

    #mime_obj["From"] = "loquesea@mimail.com" no sirve de mucho

    # esto podría ir en blanco y llegaría pero el cliente de correo no podría mostrar
    # el o los receptores es decir irian como Bcc
    mime_obj["To"] = ", ".join(get_cc_recipients())

    plain_text = "This is a plain text example"
    mime_objtext1 = MIMEText(plain_text, "plain")
    mime_objtext2 = MIMEText(html, "html")

    mime_obj.attach(mime_objtext1)
    mime_obj.attach(mime_objtext2)

    smtp_obj = get_smtpssl_object()
    smtp_obj.set_debuglevel(1)

    smtp_obj.sendmail(
        "",
        get_cc_recipients()+get_bcc_recipients(),
        mime_obj.as_string()
    )
    smtp_obj.close()


if __name__ == "__main__":
    html = get_html_template()
    send_email_html(html)
