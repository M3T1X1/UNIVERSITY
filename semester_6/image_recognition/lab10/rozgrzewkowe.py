import torch
import torchvision
from PIL import Image
from matplotlib import pyplot as plt
from torchvision.models.segmentation import DeepLabV3_MobileNet_V3_Large_Weights, deeplabv3_mobilenet_v3_large
from torchvision.transforms import functional as F
from torchvision.utils import draw_bounding_boxes, draw_segmentation_masks
from torchvision.models.detection import (
    fasterrcnn_mobilenet_v3_large_fpn,
    FasterRCNN_MobileNet_V3_Large_FPN_Weights,
)

device = "cuda" if torch.cuda.is_available() else "cpu"

det_weights = FasterRCNN_MobileNet_V3_Large_FPN_Weights.DEFAULT
detector = fasterrcnn_mobilenet_v3_large_fpn(weights=det_weights).to(device).eval()

seg_weights = DeepLabV3_MobileNet_V3_Large_Weights.DEFAULT
segmenter = deeplabv3_mobilenet_v3_large(weights=seg_weights).to(device).eval()

raw_img = Image.open("kosmita.jpg").convert("RGB")
tensor_img = F.to_tensor(raw_img)
input_tensor = (tensor_img * 255).to(torch.uint8)

det_input = det_weights.transforms()(raw_img).unsqueeze(0).to(device)
seg_input = seg_weights.transforms()(raw_img).unsqueeze(0).to(device)

with torch.no_grad():
    det_output = detector(det_input)[0]
    seg_output = segmenter(seg_input)["out"][0]

keep = det_output["scores"] > 0.4
boxes = det_output["boxes"][keep]
labels = [det_weights.meta["categories"][i] for i in det_output["labels"][keep]]

orig_h, orig_w = input_tensor.shape[1:]
seg_output = F.resize(seg_output, [orig_h, orig_w])

seg_predictions = seg_output.argmax(0)
cat_ids = torch.unique(seg_predictions)
cat_ids = cat_ids[cat_ids > 0]

res = draw_bounding_boxes(input_tensor, boxes, labels=labels, colors="red", width=3)

if len(cat_ids) > 0:
    final_masks = seg_predictions == cat_ids[:, None, None]
    res = draw_segmentation_masks(res, final_masks, alpha=0.5)

plt.figure(figsize=(12, 8))
plt.imshow(res.permute(1, 2, 0))
plt.axis("off")
plt.show()