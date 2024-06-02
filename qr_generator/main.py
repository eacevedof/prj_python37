
import qrcode
from PIL import Image

css = {
    "background": (255, 255, 255),
    "color": (0, 0, 0)
}

# Generate QR code
qr_code = qrcode.QRCode(
    version=1,
    error_correction=qrcode.constants.ERROR_CORRECT_H,
    box_size=10,
    border=2,
)
url = "http://elchalanaruba.com/la-carta-con-precios"
qr_code.add_data(url)
qr_code.make(fit=True)
qr_code.make_image(
    back_color=(255, 195, 235), fill_color=(55, 95, 35)
).save("./qr_images/qr_url.png")

# image
qr_image = qr_code.make_image()

image_logo = Image.open("./logos/chalan.jpg")

logo_size = min(qr_image.size) // 5
logo_pos = ((qr_image.size[0] - logo_size) // 2, (qr_image.size[1] - logo_size) // 2)

image_logo = image_logo.resize((logo_size, logo_size))
qr_image.paste(image_logo, logo_pos)

qr_image.save("./qr_images/qr_url_logo.png")
