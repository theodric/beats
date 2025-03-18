# beats
Swatch Internet Time 'beats' for the Linux CLI in Python, C, x86_64 assembly, and aarch64 (Raspberry Pi 4) assembly

Exactly what it says on the tin: now you can get the current beat on the CLI.  
More detailed READMEs for each of the three versions are available in their respective subdirectories.

All of these print out three decimal places of accuracy, for the hell of it.  
Obviously if you only want the current beat, you can just pass the output through awk, e.g.  
`beats | awk -F. '{print $1}'`
