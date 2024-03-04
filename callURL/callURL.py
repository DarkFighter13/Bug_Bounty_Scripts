import socket
import requests
import sys

def req(url):
    try:
        response = requests.get(url)
        statusCode = response.status_code
        return statusCode
    except requests.RequestException as e:
        """ print(f"An Error Occurred : {e}") """
        return None


def file(file):
    print('opinning FILE: ', file)
    try:
        with open(file, 'r') as urls:
            for url in urls:
                res = req(url.strip())
                if res:
                    print(f'URL {url.strip()}\tStatus {res}')
                else:
                    print(f'Failed To Get This Url {url.strip()}')
    except FileNotFoundError:
        print(f'File "{file}" Not Found!')


def specificURL(url):
    res = req(url)
    if res:
        print(f'URL {url}\tStatus {res}')
    else:
        print(f'Failed To Request This URL : {url}')

if (len( sys.argv ) <= 1):
    print('Usage:\n\tpython', sys.argv[0] , '-f path/to/urls/file.txt \n\tor \n\tpython', sys.argv[0] , '-u https://specific/url.com\n\tor\n\tpython', sys.argv[0], ' (-h | --help ) For Help List')
elif (len( sys.argv ) == 2):
    if (sys.argv[1] == '-h') or (sys.argv[1] == '--help'):
        print('Help List:')
    else:
        print('Usage:\n\tpython', sys.argv[0] , '-f path/to/urls/file.txt \n\tor \n\tpython', sys.argv[0] , '-u https://specific/url.com\n\tor\n\tpython', sys.argv[0], ' (-h | --help ) For Help List')
else:
    if sys.argv[1] == '-f':
        file(sys.argv[2])
    elif sys.argv[1] == '-u':
        specificURL(sys.argv[2])
    elif (sys.argv[1] == '-h') or (sys.argv[1] == '--help'):
        print('Help List:')
    else:
        print('Usage:\n\tpython', sys.argv[0] , '-f path/to/urls/file.txt \n\tor \n\tpython', sys.argv[0] , '-u https://specific/url.com\n\tor\n\tpython', sys.argv[0], ' (-h | --help ) For Help List')


