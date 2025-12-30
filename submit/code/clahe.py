import cv2
import numpy as np
import os

input_dir = "images"
output_dir = "images_clahe"
os.makedirs(output_dir, exist_ok=True)

for img_name in os.listdir(input_dir):
    if img_name.lower().endswith(('.png', '.jpg', '.jpeg')):
        img_path = os.path.join(input_dir, img_name)
        img = cv2.imread(img_path)
        
        # 转换为LAB颜色空间
        lab = cv2.cvtColor(img, cv2.COLOR_BGR2LAB)
        l, a, b = cv2.split(lab)
        
        # 应用CLAHE到L通道
        clahe = cv2.createCLAHE(clipLimit=4.0, tileGridSize=(8, 8))
        l = clahe.apply(l)
        
        # 合并通道并转回BGR
        enhanced = cv2.merge((l, a, b))
        enhanced = cv2.cvtColor(enhanced, cv2.COLOR_LAB2BGR)
        
        # 保存
        output_name = os.path.splitext(img_name)[0] + ".jpg"
        cv2.imwrite(os.path.join(output_dir, output_name), enhanced)
        print(f"增强: {img_name}")

print(f"增强完成，保存到 {output_dir}")