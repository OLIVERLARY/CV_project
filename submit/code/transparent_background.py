import cv2
import numpy as np
import os
import glob

def preprocess_transparent_images(input_dir, output_dir=None):

    if output_dir is None:
        output_dir = input_dir + "_rgb"
    
    os.makedirs(output_dir, exist_ok=True)
    
    for img_file in glob.glob(os.path.join(input_dir, "*.png")):
        img = cv2.imread(img_file, cv2.IMREAD_UNCHANGED)
        
        if img is None:
            continue
            
        filename = os.path.basename(img_file)
        
        if len(img.shape) == 3 and img.shape[2] == 4:
            rgb_img = img[:, :, :3]
            
            output_path = os.path.join(output_dir, filename)
            cv2.imwrite(output_path, rgb_img)
            print(f"处理: {filename} -> RGB格式")
        else:
            shutil.copy2(img_file, os.path.join(output_dir, filename))
    
    return output_dir

preprocess_transparent_images("/home/cv25_022/PGSR/data/lotso/input")