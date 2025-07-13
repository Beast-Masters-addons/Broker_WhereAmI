import os
import shutil

from yaml import load, dump
from yaml import Loader, Dumper

game = os.getenv('GAME_VERSION')
print('Building for', game)
main_folder = os.path.realpath(os.path.join(os.path.dirname(__file__), '..'))

with open(os.path.join(main_folder, '.pkgmeta_base'), 'r', encoding='utf8') as fp:
    data = load(fp, Loader=Loader)

    if game == 'classic':
        data['externals']['libs/LibTouristClassicEra'] = {'url': 'https://repos.wowace.com/wow/libtourist-classic-era',
                                                          'tag': 'latest'}
    elif game == 'wrath':
        data['externals']['libs/LibTourist-3.0'] = {'url': 'https://repos.wowace.com/wow/libtourist-3-0/trunk',
                                                    'tag': 'r100'}
    elif game == 'cata':
        data['externals']['libs/LibTouristClassic'] = {'url': 'https://repos.wowace.com/wow/libtourist-classic',                                                 'tag': 'WoW-4.4.2-release1'}
    elif game == 'mists':
        data['externals']['libs/LibTouristClassic'] = {'url': 'https://repos.wowace.com/wow/libtourist-classic',
                                                       'tag': 'latest'}
    elif game == 'retail':
        data['externals']['libs/LibTourist-3.0'] = {'url': 'https://repos.wowace.com/wow/libtourist-3-0/trunk',
                                                    'tag': 'latest'}
    else:
        raise RuntimeError("Invalid game version %s" % game)

with open(os.path.join(main_folder, '.pkgmeta'), 'w', encoding='utf8') as fp:
    output = dump(data, Dumper=Dumper)
    fp.write(output)

shutil.copy(os.path.join(main_folder, 'files', game, 'Broker_WhereAmI.toc'),
            os.path.join(main_folder, 'Broker_WhereAmI.toc'))
