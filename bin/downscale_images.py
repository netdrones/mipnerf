import os
import cv2 as cv

def downscale_image(img, scale_factor):
    w = int(img.shape[1] * scale_factor / 100)
    h = int(img.shape[0] * scale_factor / 100)
    dim = (w, h)
    return cv.resize(img, dim, interpolation=cv.INTER_AREA)

if __name__ == '__main__':
    os.mkdir('picnic_nerf_001/images_4')
    os.mkdir('picnic_nerf_001/images_8')
    images = os.listdir('picnic_nerf_001/images')
    for image in images:
        print(f'Downscaling image picnic_nerf_001/images/{image}')
        base = image.split('.')[0]
        img = cv.imread(f'picnic_nerf_001/images/{image}')
        image_4 = downscale_image(img, 4)
        image_8 = downscale_image(img, 8)
        cv.imwrite(f'picnic_nerf_001/images_4/{base}.png', image_4)
        cv.imwrite(f'picnic_nerf_001/images_8/{base}.png', image_8)
