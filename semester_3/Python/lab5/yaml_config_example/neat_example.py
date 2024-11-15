from dataclasses import dataclass
from typing import List
from copy import deepcopy

from lab4.yaml_config_example.config_util import load_config, save_config

"""
Przykład wczytywania konfiguracji do typowanych obiektów
"""


@dataclass
class Dirs:
    input: str
    output: str


@dataclass
class MyAppConfig:
    """
    Przykładowa klasa reprezentująca zawartość pliku konfiguracyjnego.
    """
    dirs: Dirs
    max_file_mb: int
    supported_formats: List[str]


if __name__ == '__main__':
    config_file = "configfile.yaml"

    # Wczytanie konfiguracji
    # Dzięki podaniu klasy jako drugi argument, wczytana zawartość pliku będzie parsowana na typowany obiekt.
    # Funkcja autouzupełniania będzie sprawnie działała
    config = load_config(file_path=config_file, cls=MyAppConfig)
    print(config)

    # Zmodyfikowanie konfiguracji
    modified_config = deepcopy(config)
    modified_config.supported_formats.append(".gif")
    save_config(config=modified_config, file_path="./modified_config.yaml")

    # # Bardzo łatwo jest stworzyć nową instancję konfiguracji, ryzyko błędów jest o wiele mniejsze
    # another_config = MyAppConfig(dirs=Dirs(input="inp", output="out"), max_file_mb=40, supported_formats=[".avi"])
    # save_config(config=another_config, file_path="./another_config.yaml")
    # cf = load_config(file_path="./another_config.yaml", cls=MyAppConfig)

    pass
