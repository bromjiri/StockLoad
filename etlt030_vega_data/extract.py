import tarfile
import glob
import os, shutil
from datetime import datetime


def move_file(file):
    print(file)

    file_parts = os.path.basename(file).split('.')
    base = file_parts[0]
    extension = file_parts[1]
    new_path = file_date + '_' + str(base) + '_' + str(timestamp) + '.' + str(extension)
    shutil.move(file, new_path)


def extract_files(file):
    print('extracting archive: ' + file)
    tar = tarfile.open(file, "r:gz")
    tar.extractall(path=extract_dir)

    for member in tar.getmembers():
        if member.name.endswith('.csv'):
            move_file(extract_dir + '/' + member.name)

    tar.close()


def get_timestamp(filepath):
    timestamp = os.path.basename(filepath).split('.')[-2]
    return int(timestamp)


# tar files setup
input_tar_dir = "new_archives"
old_tar_dir = "old_archives"
tar_file_mask = input_tar_dir + '/*tgz'

# for each archive in new_archives
for tar_file in glob.glob(tar_file_mask):
    timestamp = get_timestamp(tar_file)
    file_date = datetime.fromtimestamp(timestamp).strftime('%Y%m%dT%H%M%S')

    # create dir for extraction
    extract_dir = "vega_" + str(timestamp)
    if os.path.exists(extract_dir):
        # delete if already exists
        shutil.rmtree(extract_dir)
    os.makedirs(extract_dir)

    # extract tar
    extract_files(tar_file)

    # move tar to old_archives
    used_tar_path = old_tar_dir + '/' + tar_file.split('\\')[1]
    shutil.move(tar_file, used_tar_path)

    # remove dir
    shutil.rmtree(extract_dir)
