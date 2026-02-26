# Evaluation of ORB-SLAM3 for Real-Time Monocular Applications
## Overview
This project evaluates the performance and processing time of ORB-SLAM3 in different indoor scenarios with varying lighting conditions and image resolutions.

The focus is on:
- Tracking stability
- Runtime behavior
- MapPoint growth
- Influence of image resolution
- Influence of lighting conditions

No ground truth was used. The evaluation is based on internal SLAM metrics.

---

## Framework

This project uses:

- ORB-SLAM3 (monocular mode)
- Custom preprocessing scripts for video preparation
- TUM-style dataset format

ORB-SLAM3 was not modified. The focus of this project is experimental evaluation.

---

## Experimental Setup

- Devices: iPhone recording, AMD Ryzen5 CPU
- Environment: Indoor
- Mode: Offline processing
- Input: Extracted image frames
- Output: KeyFrameTrajectory.txt

---

## Tested Parameters

### Image Resolution

| Resolution | Description |
|------------|------------|
| 1440x1920  | Original resolution |
| 720x960    | Medium resolution |

### Lighting

- Normal lighting
- Low-light condition

---

## Metrics Observed

- Mean tracking time
- Tracking loss events

---

## Results (Example)
The main tests were made in this 3.5 x 7.5 m large testing room. The test video for the upcoming pictures was 45 seconds long and was a slow walk through the corridor a turn and a slow walk back. The video started and ended at the door on the right and was done with normal lighting.
![main](https://github.com/Quitzu/Evaluation-of-ORB-SLAM3-for-Real-Time-Monocular-Applications/blob/main/bild_flur.jpg)
The first test was done with the original resolution of 1440x1920. The tracking went pretty well and precise, as you can clearly see straight outlines and a good representation of the whole corridor. But it's aswell not perfect, there are a couple of outliers in the map and some rather clear spots. The algorithm took 90 seconds for processing, which is far from real-time!
![high](https://github.com/Quitzu/Evaluation-of-ORB-SLAM3-for-Real-Time-Monocular-Applications/blob/main/map_flur_1440.png)
The second test with a medium resolution of 720x960. I had to tweek the ORB-features for this one a little bit, it takes more and worse Keypoints, as it would otherwise lose track at some point. As shown in the next picture the tracking wasn't bad either, there are a couple more outliers and the outlines aren't as straight anymore, but the trajectory looks almost the same. With the algorithm only taking 48 seconds this could reach real-time with some more tweaking.
![low](https://github.com/Quitzu/Evaluation-of-ORB-SLAM3-for-Real-Time-Monocular-Applications/blob/main/map_flur_720.png)

| Resolution | Avg. Tracking Time | Tracking Stability |
|------------|--------------------|--------------------|
| High       | double the record  | Stable             |
| Medium     | ~real-time         | Most stable        |

---

## Observations

- Medium resolution achieved the best balance between runtime and stability.
- Lower resolution reduced computational cost but increased tracking loss.
- Poor lighting significantly reduced feature detection and MapPoint density.
- MapPoint growth correlates with scene structure richness.

---

## Limitations

- No ground truth available
- Limited number of test sequences
- No real-time evaluation
- Only monocular configuration tested

---

## Reproducibility

To prepare a dataset:

```bash
./scripts/prepare_sequence.sh video.mp4 960 540 30
