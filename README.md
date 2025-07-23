# Matrix Completion via Non-Convex Relaxation and Adaptive Correlation Learning

This repository is our implementation of

[Xuelong Li, Hongyuan Zhang, and Rui Zhang, &#34;Matrix Completion via Non-Convex Relaxation and Adaptive Correlation Learning,&#34; *IEEE Transactions on Pattern Analysis and Machine Intelligence*, vol. 45, no. 2, pp. 1981-1991, 2023](https://ieeexplore.ieee.org/document/9729616).

In this paper, we introduce a new surrogate for matrix completion, which is equivalent to the nuclear norm. 

In particular, we prove the upper-bound of an approximate/inexact closed-form solution, which is a crucial step of the optimization. The surrogate and its optimization make the matrix completion more compatible for additional learning mechanisms. 

If you have issues, please email:

hyzhang98@gmail.com or hyzhang98@mail.nwpu.edu.cn.

## Descriptions of Files

- image_main.m: An example of how to run the code
- ncarl_no_noise: The source code of NCARL
- ncarl.m: The noisy extension 

## Citation

```
@article{NCARL,
  author={Li, Xuelong and Zhang, Hongyuan and Zhang, Rui},
  journal={IEEE Transactions on Pattern Analysis and Machine Intelligence}, 
  title={Matrix Completion via Non-Convex Relaxation and Adaptive Correlation Learning}, 
  year={2022},
  volume={45},
  number={2},
  pages={1981--1991},
  doi={10.1109/TPAMI.2022.3157083}
}

```
