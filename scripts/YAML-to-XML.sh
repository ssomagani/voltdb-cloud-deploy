#! /usr/local/bin/python3

import requests 
import xml.etree.ElementTree as ET 
import datetime
import time
import sys, yaml

TEMPLATE_XML = sys.argv[1]
VALUES_YAML = sys.argv[2]

def setValues(element, dict_tree):
    for key in dict_tree:
        if type(dict_tree[key]) == dict: 
            curElement = element.find(key)
            if curElement is None:
                curElement = addElement(element, key)
            setValues(curElement, dict_tree[key])
        else:
            setAttribute(element, key, dict_tree[key])

def addElement(parent, tag):
    return ET.SubElement(parent, tag)

def setAttribute(element, attr_name, attr_value):
    element.set(attr_name, str(attr_value))

def main():
    xml = ET.parse(TEMPLATE_XML)
    root = xml.getroot();
    with open(VALUES_YAML, 'r') as stream:
        try:
            generator = yaml.load_all(stream)
            for dict in generator:
                setValues(root, dict)
        except yaml.YAMLError as exc:
            print(exc)
    xml.write('deployment.xml')

if __name__ == "__main__": 
  
    # calling main function 
    main() 
