#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --time=12:00:00
#SBATCH --mem=30GB
#SBATCH --gres=gpu:1
#SBATCH --job-name=pic4_ckpt_gpu
#SBATCH --output=pic4_ckpt_gpu.out
#SBATCH --mail-type=END
#SBATCH --mail-user=yh832@nyu.edu

module purge

SINGULARITY_IMAGE=/scratch/work/public/singularity/ubuntu-20.04.1.sif
OVERLAY_FILE=/scratch/work/public/examples/greene-getting-started/overlay-15GB-500K-pytorch.ext3

singularity exec \
            --nv --overlay $OVERLAY_FILE $SINGULARITY_IMAGE \
            /bin/bash -c "source /ext3/miniconda3/bin/activate; 
            python /scratch/yh832/cv_project/neural_style_gpu.py train --transformer-net transformer_dense --dataset /scratch/yh832/cv_project/coco_dataset --style-image /scratch/yh832/cv_project/style_image/pic4.jpeg --save-model-dir /scratch/yh832/cv_project/models/pic2_4 --checkpoint-model-dir /scratch/yh832/cv_project/models/pic2_4 --epochs 2"