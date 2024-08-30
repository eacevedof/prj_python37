import qrcode
from PIL import Image, ImageDraw

css = {
    "background": (208, 31, 47),
    "color": (255, 255, 255)
}

URL_TO_QR = "http://elchalanaruba.com/la-carta-con-precios"
PATH_IMG_MIDDLE = "./logos/chalan-head.png"
IMG_NAME = "qr_chalan.png"

def _get_qr_code_with_url() -> qrcode.QRCode:
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
    return qr_code


def _get_qr_image_from_qr_code(qr_code: qrcode.QRCode) -> Image:
    # Generate QR image
    qr_image = qr_code.make_image(
        back_color=css.get("background"),
        fill_color=css.get("color")
    )

    # Generate mask
    mask = Image.new("L", qr_image.size, 0)
    draw = ImageDraw.Draw(mask)
    draw.rounded_rectangle([0, 0, *qr_image.size], radius=20, fill=255)

    # Apply mask
    qr_image.putalpha(mask)
    return qr_image


def _append_logo_to_qr_image(qr_image: Image) -> Image:
    image_logo = Image.open(PATH_IMG_MIDDLE)
    #image_logo = Image.open("./logos/chalan-full.png")
    logo_size = min(qr_image.size) // 5
    logo_pos = ((qr_image.size[0] - logo_size) // 2, (qr_image.size[1] - logo_size) // 2)

    image_logo = image_logo.resize((logo_size, logo_size))
    qr_image.paste(image_logo, logo_pos)
    return qr_image


if __name__ == "__main__":
    qr_code = _get_qr_code_with_url()
    qr_image = _get_qr_image_from_qr_code(qr_code)
    _append_logo_to_qr_image(qr_image)
    qr_image.save(f"./qr_images/{IMG_NAME}")
