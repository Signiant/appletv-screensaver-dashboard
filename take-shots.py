import pprint
import argparse
import os,sys,time
import yaml
from selenium import webdriver

def take_shot(driver,url,filename):
    driver.get(url)
    time.sleep(10)
    driver.save_screenshot(filename)

def take_shots(driver,config_map):
    base_filename_path = os.path.join(config_map['common']['screenshot_folder'], '')

    if not os.path.isdir(base_filename_path):
        print base_filename_path + " does not exist - creating"
        os.makedirs(base_filename_path)

    for url in config_map['urls']:
        filename = base_filename_path + url['name'].replace(" ", "_") + ".png"
        print "Snapshotting url " + url['url'] + " to filename " + filename

        if os.path.exists(filename):
            os.remove(filename)

        take_shot(driver,url['url'],filename)

def init_selenium():
    try:
        driver = webdriver.Firefox()
    except Exception as e:
        print "Error: Unable to initalize selenium driver " + str(e)
        driver = ""

    return driver

def read_config_file(path):
    config_map = []

    try:
        config_file_handle = open(path)
        config_map = yaml.load(config_file_handle)
        config_file_handle.close()
    except:
        print "Error: Unable to open config file %s or invalid yaml" % path

    return config_map

def main(argv):
    parser = argparse.ArgumentParser(description='Create screenshots')
    parser.add_argument('-d','--debug', help='Enable debug output',action='store_true')
    parser.add_argument('-c','--config', help='Full path to a config file',required=True)

    args = parser.parse_args()
    config_map = read_config_file(args.config)
    selenium_driver = init_selenium()
    take_shots(selenium_driver,config_map)
    selenium_driver.close()

if __name__ == "__main__":
   main(sys.argv[1:])
