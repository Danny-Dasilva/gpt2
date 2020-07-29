from shutil import copyfile, copytree, rmtree
import os

def copy_file(filename, dst):
    src = os.path.join('models', '117M', filename)
    dst = os.path.join(dst, filename)
    print(dst)
    copyfile(src, dst)
def move(model_name):
    src = os.path.join('checkpoint', model_name)
    dst = os.path.join('models', model_name)
    try:
        rmtree(dst)
    except:
        pass
    copytree(src, dst)
    print("working")
    copy_file('encoder.json', dst)
    copy_file('hparams.json', dst)
    copy_file('vocab.bpe', dst)
