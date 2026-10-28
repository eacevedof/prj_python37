# debuger.py
from os import getenv

def debugpy_start():
    #if getenv("DEBUGGER") == "True":
    if 1==1:    
        import multiprocessing

        if multiprocessing.current_process().pid > 1:
            import debugpy

            debugpy.listen(("0.0.0.0", 5678))
            print("⏳ VS Code debugger can now be attached, press F5 in VS Code ⏳", flush=True)
            debugpy.wait_for_client()
            print("🎉 VS Code debugger attached, enjoy debugging 🎉", flush=True)