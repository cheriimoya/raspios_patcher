Raspios patcher
===

This small docker container will download the latest raspios.

After downloading the zip, it will be extracted, mounted and patched with any
public keys that are found in the `keys` directory.

Usage
---

Simply place any public ssh keys you want to be added to the image to the
`keys` directory, i.e., by running `cp ~/.ssh/*.pub keys/`, then run
`docker-compose up` in the project root. Everything else will happen
automatically. Also, if any keys are supplied, ssh password authentication is
being disabled.

If there is a file named `wpa_supplicant.conf` in the project root, it will
also be patched right into the image.

After the job has completed, you will be left with the patched raspios image
file which is ready to be written to an SD card by using `dd` or whatever.
