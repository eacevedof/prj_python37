import qrcode
from PIL import Image

# Generate QR code
qr = qrcode.QRCode(
    version=1,
    error_correction=qrcode.constants.ERROR_CORRECT_H,
    box_size=10,
    border=4,
)
url = "http://elchalanaruba.com/la-carta-con-precios"
qr.add_data(url)
qr.make(fit=True)

img_qr = qr.make_image(fill="black", back_color="white")

# Open logo image
logo = Image.open("./logos/chalan.jpg")

# Calculate logo size and position
logo_size = min(img_qr.size)
logo_pos = ((img_qr.size[0] - logo_size) // 2, (img_qr.size[1] - logo_size) // 2)

# Resize and paste logo image
logo = logo.resize((logo_size, logo_size))
img_qr.paste(logo, logo_pos)

# Save resulting image
img_qr.save("./qr_images/qr_with_logo.png")