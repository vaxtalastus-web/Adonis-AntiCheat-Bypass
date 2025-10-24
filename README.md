# Adonis-AntiCheat-Bypass
A simple &amp; undetected bypass for the Adonis "Anti" & "Anti-Cheat" module.

# Required Functions
The following UNC & sUNC functions are required:

1. getgc: For retrieving adonis-related closures from the garbage collector
2. hookfunction: For detouring adonis-related closures

# How The Detections Work

Adonis is an admin script that experience developers can use freely, that also comes packed with optional code designed to curb cheating. The 2 modules "Anti" and "Anti Cheat" are responsible for this, and serve 2 different yet similar purposes:

1. The **Anti** module appears to be an **anti exploit** module, targeting executors or poor scripts directly.
2. The **Anti Cheat** module appears to be just that, an **anti cheat**, checking for speed hacks, noclip, anti-idle, and more, *locally*.

Both of these modules will rely on the same function to report detections to the server, called **Detected**. It is an anonymous function that is defined inside the **Anti** module:

<img width="1599" height="310" alt="Detected Function Code" src="https://github.com/user-attachments/assets/f534575a-9ea8-4273-b351-32065462c414" />

When called, it will call the network **Send** function to let the server know about the detection. Half a second after reporting the detection, it will check if the caller wanted to kick you or crash your game.

Adonis will also protect it's Detected function using **debug.info**. It will first cache all information about the **Detected** function on startup (like source identifier, line number, argument count, etc). It will then continuously call **debug.info** and compare the results with the 1st cached result.

This works because the **Detected** function is a *lua closure*. Depending on how your executor performs hooking, the function itself will likely have to be modified in some way to make it jump to the desired detour (which might be a wrapped *c closure* automatically on some executors) when called. Whether this detection is effective or not will depend on your executor and their method of hooking lua closures. When Adonis detects any change with the functions info, it will crash itself:

<img width="881" height="308" alt="Hook Detection Code" src="https://github.com/user-attachments/assets/408bfa5b-549e-4038-adf6-daf4fbefa79c" />

# Why It's Effective

Adonis has many, many, detections in both it's **Anti** and **Anti-Cheat** module. Instead of targeting each detection, we can simply target the code responsible for the consequences & snitching.

This means that by blocking the **Detected** function, all the Adonis detections will still be running & working, it just cannot do anything about it, nor can it tell anyone about it.
