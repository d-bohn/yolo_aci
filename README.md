# YOLO_aci
Code and workflow for building [YOLO](https://pjreddie.com/darknet/yolo/)
in Docker Hub and modifying it with Singularity Hub for use with PSU
ACI HPC clusters.

## Quick Start

### Command line
#### Images
```
./darknet detect cfg/yolov3.cfg yolov3.weights data/dog.jpg
```

#### Videos
```
./darknet detector demo cfg/coco.data cfg/yolov3.cfg yolov3.weights <video file>
```

### Python3

#### Images
```
python yolo.py --image /path/to/image.jpg --yolo yolo-coco
```

#### Video
```
python3 yolo_video.py --input /path/to/vid.mp4 \
	--output /path/to/output/save.avi --yolo yolo-coco
  ```
