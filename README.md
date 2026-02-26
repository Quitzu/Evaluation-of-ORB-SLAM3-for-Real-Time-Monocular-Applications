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

- Device: iPhone recording
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
The main tests were made in this 3.5 x 7.5 m large testing room.
![main](https://github.com/Quitzu/Evaluation-of-ORB-SLAM3-for-Real-Time-Monocular-Applications/blob/main/bild_flur.jpg)
![high](https://github.com/Quitzu/Evaluation-of-ORB-SLAM3-for-Real-Time-Monocular-Applications/blob/main/map_flur_1440.png)
![low](https://github.com/Quitzu/Evaluation-of-ORB-SLAM3-for-Real-Time-Monocular-Applications/blob/main/map_flur_720.png)

| Resolution | Avg. Tracking Time | MapPoints | Tracking Stability |
|------------|-------------------|-----------|--------------------|
| High       | Higher runtime    | More MPs  | Stable             |
| Medium     | Balanced          | Good MPs  | Most stable        |

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
