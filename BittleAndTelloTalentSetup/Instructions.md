# Environment Setup: Petoi Bittle & Tello Talent

Here's everything you need to do to be able to code the Petoi Bittle robot dog and/or the Tello Talent flying drone.

## Setting Up The Devices

To setup the Petoi Bittle:

Make sure you can connect to and upload/update firmware on the Petoi Bittle. Follow the instructions below.

* [Installing the Petoi Desktop App](https://docs.petoi.com/desktop-app/introduction)
* [Uploading/Updating Firmware](https://docs.petoi.com/desktop-app/firmware-uploader)

Note, the Bittle X uses `BiBoard_V0_1` or `BiBoard_V0_2` as the board version and the `ESP32` as the [development module](https://github.com/PetoiCamp/OpenCatEsp32).

## Writing Block-Based Code

1. Go to [Mind Plus Petoi Coding Blocks Instructions](https://docs.petoi.com/block-based-programming/petoi-coding-blocks) and follow the instructions. You don't need to do any configuration with the firmware.
   1. If you're coding the Robot Dog, the Bittle X already has all that supported already. Just download the application and get the Petoi Coding Blocks module imported.
   2. If you're coding the Tello Talent drone, you need to make sure the module for that is imported into Mind+. Follow the instructions here to do that. [Mind Plus Setup For Tello Talent](https://mindplus.dfrobot.com/RMTT)
2. Once the module is imported, connect the Bittle X or Tello Talent. The Bittle connects over Bluetooth, the Tello Talent connects via WiFi.

## Workshop Ideas

Use the resources below to get ideas on using the Petoi Bittle and Tello Talent for workshops.

* [Petoi Bittle Community](https://www.petoi.com/pages/petoi-open-source-extensions-user-demos-and-hacks)
* [Iowa State Bittle Course](https://www.cyio.iastate.edu/robotics/)

## Troubleshooting

### Petoi Bittle Not Responding To Commands

* Completely remove the device from the Bluetooth on the PC and re-add it. Close the Mind+ application and re-run it.
* Alternatively, close all COM/Bluetooth ports on the PC. You can clear them using terminal commands, then re-connect the Bittle.
