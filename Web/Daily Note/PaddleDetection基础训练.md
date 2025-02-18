![image](https://user-images.githubusercontent.com/48054808/160532560-34cf7a1f-d950-435e-90d2-4b0a679e5119.png)

# PaddleDetection基础训练

# PaddleDetection 简介

PaddleDetection 是百度框架 PaddlePaddle 下的一个开源目标检测框架，集成了许多开箱即用的模型，是一个端到端开发套件，在提供丰富的模型组件和测试基准的同时，注重端到端的产业落地应用，通过打造产业级特色模型|工具、建设产业应用范例等手段，帮助开发者实现数据准备、模型选型、模型训练、模型部署的全流程打通，快速进行落地应用。

# 安装

## 环境要求

- PaddlePaddle 2.3.2
- OS 64 位操作系统
- Python 3(3.5.1+/3.6/3.7/3.8/3.9/3.10)，64 位版本
- pip/pip3(9.0.1+)，64 位版本
- CUDA >= 10.2
- cuDNN >= 7.6

PaddleDetection 依赖 PaddlePaddle 版本关系：

| PaddleDetection 版本 | PaddlePaddle 版本 |                                      备注                                      |

| :------------------: | :---------------: | :----------------------------------------------------------------------------: |

|       develop        |      >=2.3.2      |                               默认使用动态图模式                               |

|     release/2.6      |      >=2.3.2      |                               默认使用动态图模式                               |

|     release/2.5      |     >= 2.2.2      |                               默认使用动态图模式                               |

|     release/2.4      |     >= 2.2.2      |                               默认使用动态图模式                               |

|     release/2.3      |    >= 2.2.0rc     |                               默认使用动态图模式                               |

|     release/2.2      |     >= 2.1.2      |                               默认使用动态图模式                               |

|     release/2.1      |     >= 2.1.0      |                               默认使用动态图模式                               |

|     release/2.0      |     >= 2.0.1      |                               默认使用动态图模式                               |

|    release/2.0-rc    |     >= 2.0.1      |                                       --                                       |

|     release/0.5      |     >= 1.8.4      | 大部分模型>=1.8.4 即可运行，Cascade R-CNN 系列模型与 SOLOv2 依赖 2.0.0.rc 版本 |

|     release/0.4      |     >= 1.8.4      |                               PP-YOLO 依赖 1.8.4                               |

|     release/0.3      |       >=1.7       |                                       --                                       |

## 安装说明

### 1. 安装 PaddlePaddle

```

# CUDA10.2

python -m pip install paddlepaddle-gpu==2.3.2 -i https://mirror.baidu.com/pypi/simple

  

# CPU

python -m pip install paddlepaddle==2.3.2 -i https://mirror.baidu.com/pypi/simple

```

- 更多 CUDA 版本或环境快速安装，请参考[PaddlePaddle 快速安装文档](https://www.paddlepaddle.org.cn/install/quick)
- 更多安装方式例如 conda 或源码编译安装方法，请参考[PaddlePaddle 安装文档](https://www.paddlepaddle.org.cn/documentation/docs/zh/install/index_cn.html)

请确保您的 PaddlePaddle 安装成功并且版本不低于需求版本。使用以下命令进行验证。

```

# 在您的Python解释器中确认PaddlePaddle安装成功

>>> import paddle

>>> paddle.utils.run_check()

  

# 确认PaddlePaddle版本

python -c "import paddle; print(paddle.__version__)"

```

**注意**

1. 如果您希望在多卡环境下使用 PaddleDetection，请首先安装 NCCL

### 2. 安装 PaddleDetection

**注意：**  pip 安装方式只支持 Python3

```

# 克隆PaddleDetection仓库

cd <path/to/clone/PaddleDetection>

git clone https://github.com/PaddlePaddle/PaddleDetection.git

  

# 安装其他依赖

cd PaddleDetection

pip install -r requirements.txt

  

# 编译安装paddledet

python setup.py install

```

**注意**

1. 如果 github 下载代码较慢，可尝试使用[gitee](https://gitee.com/PaddlePaddle/PaddleDetection.git)或者[代理加速](https://doc.fastgit.org/zh-cn/guide.html)。
2. 若您使用的是 Windows 系统，由于原版 cocoapi 不支持 Windows，`pycocotools`依赖可能安装失败，可采用第三方实现版本，该版本仅支持 Python3

   `pip install git+https://github.com/philferriere/cocoapi.git#subdirectory=PythonAPI`

1. 若您使用的是 Python <= 3.6 的版本，安装`pycocotools`可能会报错`distutils.errors.DistutilsError: Could not find suitable distribution for Requirement.parse('cython>=0.27.3')`, 您可通过先安装`cython`如`pip install cython`解决该问题

安装后确认测试通过：

```

python ppdet/modeling/tests/test_architectures.py

```

测试通过后会提示如下信息：

```

.......

----------------------------------------------------------------------

Ran 7 tests in 12.816s

OK

```

# 模型训练部分

paddledetection 的模型训练主要用的是 tools/train.py 这个文件，但是在训练时需要预先配置基础模型 yml，如`ppyoloe_plus_crn_l_80e_coco.yml`其结构如下：

```yml

_BASE_:

  [

    "../datasets/coco_detection.yml",

    "../runtime.yml",

    "./_base_/optimizer_80e.yml",

    "./_base_/ppyoloe_plus_crn.yml",

    "./_base_/ppyoloe_plus_reader.yml",

  ]

  

log_iter: 100 #多少个图片输出一次log

snapshot_epoch: 5 #多少个epoch保存一次参数

weights: output/ppyoloe_plus_crn_l_80e_coco/model_final #权重

  

pretrain_weights: https://bj.bcebos.com/v1/paddledet/models/pretrained/ppyoloe_crn_l_obj365_pretrained.pdparams

depth_mult: 1.0

width_mult: 1.0

```

正如文件内容所说，需要配置*BASE*中的五个文件，其中如果是 PaddleDetection 中自带的模型，*BASE*中就只要改 datasets 选项，且具体的优化器和训练配置就自己去文件中改，以`ppyoloe_plus_crn_l_80e_coco.yml`为例其 datasets 的 yml 文件如下所示：

```yml

metric: COCO

num_classes: 3

  

TrainDataset: !COCODataSet

  image_dir: image

  anno_path: train.json

  dataset_dir: 24dog/

  data_fields: ["image", "gt_bbox", "gt_class", "is_crowd"]

  

EvalDataset: !COCODataSet

  image_dir: image

  anno_path: val.json

  dataset_dir: 24dog/

  

TestDataset: !ImageFolder

  ! anno_path: val.json

  image_dir: image

  dataset_dir: 24dog/

```

`dataset.yml`的需要指向个 json 文件，如上文则是`train.json`,`val.json`，但是把测试集与评估集设为同一个。

`train.json`和`val.json`的格式如下所示

```json

{

  "images": [

    {

      "file_name": "monkey0002.jpg",

      "height": 2160.0,

      "width": 3840.0,

      "id": 0

    },

    {

      "file_name": "monkey0003.jpg",

      "height": 2160.0,

      "width": 3840.0,

      "id": 1

    },

    {

      "file_name": "monkey0004.jpg",

      "height": 2160.0,

      "width": 3840.0,

      "id": 2

    }]

}

```

`ppyoloe_plus_reader.yml`文件则是对输入图像的转换

`optimizer_80e.yml`文件时优化器部分，规定了模型训练的轮数和基础学习率

```yml

epoch: 80

  

LearningRate:

  base_lr: 0.001

  schedulers:

    - name: CosineDecay

      max_epochs: 96

    - name: LinearWarmup

      start_factor: 0.

      epochs: 5

  

OptimizerBuilder:

  optimizer:

    momentum: 0.9

    type: Momentum

  regularizer:

    factor: 0.0005

    type: L2

```

配置完上文后只需要一个命令

```bash

python tools/train.py -c config/ppyoloe/ppyoloe_plus_crn_l_80e_coco.yml

# config/ppyoloe/ppyoloe_plus_crn_l_80e_coco.yml == path to your base model yml

```

模型就会开始训练，至于训练的轮数则取决于模型何时收敛，可以在命令中加上

```bash

python tools/train.py -c config/ppyoloe/ppyoloe_plus_crn_l_80e_coco.yml > file_path

```

将命令行保存到日志中方面查看 loss 数据

训练完成后训练后参数会保存到`./output`文件夹下，里面包含`.pdema`,`.pdopt`,`.pdparams`，三个文件，其中会包含每次保存的和最终的`model_final`，可以使用以下命令进行模型评估

```bash

python tools\infer.py \

    -c configs\picodet\ppyoloe_crn_s_400e_coco.yml \

    --infer_img=24dog\image\monkey0137.jpg \

    --output_dir=infer_output --draw_threshold=0.5 \

    -o weights=output\model_final.pdparams \

    --use_vdl=True

```

如果模型效果好的话，就可以直接输出模型

```bash

python tools/export_model.py \

    -c configs/picodet/ppyoloe_crn_s_400e_coco.yml \

    -o weights=output/model_final \

    TestReader.fuse_normalize=true

```

下面提供模型的预测文件，使用此文件时需要确定能够读取到 PaddleDetection 库中`deploy/python`下的文件

```python

# Copyright (c) 2020 PaddlePaddle Authors. All Rights Reserved.

#

# Licensed under the Apache License, Version 2.0 (the "License");

# you may not use this file except in compliance with the License.

# You may obtain a copy of the License at

#

#     http://www.apache.org/licenses/LICENSE-2.0

#

# Unless required by applicable law or agreed to in writing, software

# distributed under the License is distributed on an "AS IS" BASIS,

# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.

# See the License for the specific language governing permissions and

# limitations under the License.

  

import codecs

import os

import time

import sys

  

#sys.path.append('PaddleDetection')

import json

import yaml

from functools import reduce

import multiprocessing

  

from PIL import Image

import cv2

  

import numpy as np

import paddle

from paddle.inference import Config

from paddle.inference import create_predictor

  

from preprocess import preprocess, Resize, NormalizeImage, Permute, PadStride

from utils import argsparser, Timer, get_current_memory_mb

  
  

class PredictConfig():

    """set config of preprocess, postprocess and visualize

    Args:

        model_dir (str): root path of model.yml

    """

  

    def __init__(self, model_dir):

        # parsing Yaml config for Preprocess

        deploy_file = os.path.join(model_dir, 'infer_cfg.yml')

        with open(deploy_file) as f:

            yml_conf = yaml.safe_load(f)

        self.arch = yml_conf['arch']

        self.preprocess_infos = yml_conf['Preprocess']

        self.min_subgraph_size = yml_conf['min_subgraph_size']

        self.labels = yml_conf['label_list']

        self.mask = False

        self.use_dynamic_shape = yml_conf['use_dynamic_shape']

        if 'mask' in yml_conf:

            self.mask = yml_conf['mask']

        self.tracker = None

        if 'tracker' in yml_conf:

            self.tracker = yml_conf['tracker']

        if 'NMS' in yml_conf:

            self.nms = yml_conf['NMS']

        if 'fpn_stride' in yml_conf:

            self.fpn_stride = yml_conf['fpn_stride']

        self.print_config()

  

    def print_config(self):

        print('%s: %s' % ('Model Arch', self.arch))

        for op_info in self.preprocess_infos:

            print('--%s: %s' % ('transform op', op_info['type']))

  
  

def get_test_images(infer_file):

    with open(infer_file, 'r') as f:

        dirs = f.readlines()

    images = []

    for dir in dirs:

        images.append(eval(repr(dir.replace('\n', ''))).replace('\\', '/'))

    assert len(images) > 0, "no image found in {}".format(infer_file)

    return images

  
  

def load_predictor(model_dir):

    config = Config(

        os.path.join(model_dir, 'model.pdmodel'),

        os.path.join(model_dir, 'model.pdiparams'))

    # initial GPU memory(M), device ID

    config.enable_use_gpu(2000, 0)

    # optimize graph and fuse op

    config.switch_ir_optim(True)

    # disable print log when predict

    config.disable_glog_info()

    # enable shared memory

    config.enable_memory_optim()

    # disable feed, fetch OP, needed by zero_copy_run

    config.switch_use_feed_fetch_ops(False)

    predictor = create_predictor(config)

    return predictor, config

  
  

def create_inputs(imgs, im_info):

    inputs = {}

  

    im_shape = []

    scale_factor = []

    for e in im_info:

        im_shape.append(np.array((e['im_shape'],)).astype('float32'))

        scale_factor.append(np.array((e['scale_factor'],)).astype('float32'))

  

    origin_scale_factor = np.concatenate(scale_factor, axis=0)

  

    imgs_shape = [[e.shape[1], e.shape[2]] for e in imgs]

    max_shape_h = max([e[0] for e in imgs_shape])

    max_shape_w = max([e[1] for e in imgs_shape])

    padding_imgs = []

    padding_imgs_shape = []

    padding_imgs_scale = []

    for img in imgs:

        im_c, im_h, im_w = img.shape[:]

        padding_im = np.zeros(

            (im_c, max_shape_h, max_shape_w), dtype=np.float32)

        padding_im[:, :im_h, :im_w] = np.array(img, dtype=np.float32)

        padding_imgs.append(padding_im)

        padding_imgs_shape.append(

            np.array([max_shape_h, max_shape_w]).astype('float32'))

        rescale = [float(max_shape_h) / float(im_h), float(max_shape_w) / float(im_w)]

        padding_imgs_scale.append(np.array(rescale).astype('float32'))

    inputs['image'] = np.stack(padding_imgs, axis=0)

    inputs['im_shape'] = np.stack(padding_imgs_shape, axis=0)

    inputs['scale_factor'] = origin_scale_factor

    return inputs

  
  

class Detector(object):

  

    def __init__(self,

                 pred_config,

                 model_dir,

                 device='CPU',

                 run_mode='paddle',

                 batch_size=1,

                 trt_min_shape=1,

                 trt_max_shape=1280,

                 trt_opt_shape=640,

                 trt_calib_mode=False,

                 cpu_threads=1,

                 enable_mkldnn=False):

        self.pred_config = pred_config

        self.predictor, self.config = load_predictor(model_dir)

        self.det_times = Timer()

        self.cpu_mem, self.gpu_mem, self.gpu_util = 0, 0, 0

        self.preprocess_ops = self.get_ops()

  

    def get_ops(self):

        preprocess_ops = []

        for op_info in self.pred_config.preprocess_infos:

            new_op_info = op_info.copy()

            op_type = new_op_info.pop('type')

            preprocess_ops.append(eval(op_type)(**new_op_info))

        return preprocess_ops

  

    def predict(self, inputs):

        # preprocess

        input_names = self.predictor.get_input_names()

        for i in range(len(input_names)):

            input_tensor = self.predictor.get_input_handle(input_names[i])

            input_tensor.copy_from_cpu(inputs[input_names[i]])

  

        np_boxes, np_boxes_num = [], []

  

        # model_prediction

        self.predictor.run()

        np_boxes.clear()

        np_boxes_num.clear()

        output_names = self.predictor.get_output_names()

        num_outs = int(len(output_names) / 2)

  

        for out_idx in range(num_outs):

            np_boxes.append(

                self.predictor.get_output_handle(output_names[out_idx])

                .copy_to_cpu())

            np_boxes_num.append(

                self.predictor.get_output_handle(output_names[

                                                     out_idx + num_outs]).copy_to_cpu())

  

        np_boxes, np_boxes_num = np.array(np_boxes[0]), np.array(np_boxes_num[0])

        return dict(boxes=np_boxes, boxes_num=np_boxes_num)

  
  

def predict_image(detector, image_list, result_path, threshold):

    c_results = {"result": []}

  

    for index in range(len(image_list)):

        # 检测模型图像预处理

        input_im_lst = []

        input_im_info_lst = []

  

        im_path = image_list[index]

        im, im_info = preprocess(im_path, detector.preprocess_ops)

  

        input_im_lst.append(im)

        input_im_info_lst.append(im_info)

        inputs = create_inputs(input_im_lst, input_im_info_lst)

  

        image_id = os.path.basename(im_path).split('.')[0]

  

        # 检测模型预测结果

        det_results = detector.predict(inputs)

  

        # 检测模型写结果

        im_bboxes_num = det_results['boxes_num'][0]

  

        if im_bboxes_num > 0:

            bbox_results = det_results['boxes'][0:im_bboxes_num, 2:]

            id_results = det_results['boxes'][0:im_bboxes_num, 0]

            score_results = det_results['boxes'][0:im_bboxes_num, 1]

  

            for idx in range(im_bboxes_num):

                if float(score_results[idx]) >= threshold:

                    c_results["result"].append({"image_id": image_id,

                                                "type": int(id_results[idx]) + 1,

                                                "x": float(bbox_results[idx][0]),

                                                "y": float(bbox_results[idx][1]),

                                                "width": float(bbox_results[idx][2]) - float(bbox_results[idx][0]),

                                                "height": float(bbox_results[idx][3]) - float(bbox_results[idx][1]),

                                                "segmentation": []})

  

    # 写文件

    with open(result_path, 'w') as ft:

        json.dump(c_results, ft)

  
  

def main(infer_txt, result_path, det_model_path, threshold):

    pred_config = PredictConfig(det_model_path)

    detector = Detector(pred_config, det_model_path)

  

    # predict from image

    img_list = get_test_images(infer_txt)

    predict_image(detector, img_list, result_path, threshold)

  
  

if __name__ == '__main__':

    start_time = time.time()

    det_model_path = "model/base" #export model path

  

    threshold = 0.1

  

    paddle.enable_static()

    infer_txt = sys.argv[1]

    result_path = sys.argv[2]

  

    main(infer_txt, result_path, det_model_path, threshold)

    print('total time:', time.time() - start_time)

  

```

预测文件的使用方法为

```bash

python predict.py data.txt result.json

#data中应当包含需要预测的文件路径，result.json则是预测结果的输出

```
