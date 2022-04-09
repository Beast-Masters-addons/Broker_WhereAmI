import os
import shutil

from yaml import load, dump
from yaml import Loader, Dumper

game = os.getenv('GAME_VERSION')
with open('../.pkgmeta', 'r', encoding='utf8') as fp:
    data = load(fp, Loader=Loader)

    if game == 'classic':
        data['externals']['libs/LibTouristClassicEra'] = {'url': 'https://repos.wowace.com/wow/libtourist-classic-era',
                                                          'tag': 'latest'}
    elif game == 'bcc':
        data['externals']['libs/LibTouristClassic'] = {'url': 'https://repos.wowace.com/wow/libtourist-classic',
                                                       'tag': 'latest'}
    else:
        data['externals']['libs/LibTourist-3.0'] = {'url': 'https://repos.wowace.com/wow/libtourist-3-0/trunk',
                                                    'tag': 'latest'}

with open('../.pkgmeta', 'w', encoding='utf8') as fp:
    output = dump(data, Dumper=Dumper)
    fp.write(output)

shutil.move(os.path.join(game, 'Broker_WhereAmI.toc'), '../Broker_WhereAmI.toc')
