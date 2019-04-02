"""
theframework/components/component_log.py
"""
class ComponentLog():

    def __init__(self):
        pass

    def write(self):
        f = open("testwrite.txt", "a")
        f.write("Now the file has more content!")
        f.close()


if __name__ == "__main__":
    o = ComponentLog()
    o.write()