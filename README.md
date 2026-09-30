# Research Datasets and Experimental Data

This repository contains datasets and experimental data used in research and development studies.

## Dataset Description

This agricultural dataset consists of RGB images collected from publicly accessible online sources. 
The images were subsequently reviewed and annotated with the support of experts from the Faculty of Agriculture of Sakarya University of Applied Sciences.

Ground-truth annotations were prepared by the agricultural experts through the identification and delineation of relevant regions according to their visual and color characteristics. 
These expert-supported annotations were used as reference data for evaluating the segmentation results obtained in the associated study.

The dataset contains ten agricultural RGB images, each with a spatial resolution of 410 × 260 pixels.

## Agriculture Dataset

The agricultural image dataset used in the related study is located in the `agriculture/` directory.

The dataset contains ten agricultural RGB images together with their corresponding annotation files. The images are provided in PNG format, while the associated annotation data are provided in JSON format.

### Directory Structure

The directory structure of the agricultural dataset is organized as follows:

```text
agriculture/
├── _gt/
│   ├── field1_json/
│   ├── field2_json/
│   ├── ...
│   └── field10_json/
│
├── field1.png
├── field1.json
├── field2.png
├── field2.json
├── ...
├── field10.png
└── field10.json

### Dataset Organization

field1.png – field10.png: Agricultural RGB images used in the experiments.
field1.json – field10.json: Corresponding annotation files.
_gt/: Ground-truth and annotation-related data associated with the agricultural images.
field*_json/: Individual annotation data organized for each agricultural image.

The dataset is organized to maintain a direct correspondence between each image and its associated annotation data.

### Additional Datasets

Additional datasets and experimental data may be added to this repository as separate directories according to the corresponding research project.

### Data Usage

Please refer to the corresponding research publication and the source information associated with each dataset before using the data for further research or redistribution.
