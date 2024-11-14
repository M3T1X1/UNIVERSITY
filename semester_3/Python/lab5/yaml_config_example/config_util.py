from typing import Type, TypeVar
from dataclasses import asdict
import yaml

# Definicja typu generycznego dla klasy konfiguracyjnej
T = TypeVar("T")


# Wczytywanie konfiguracji z pliku YAML
def load_config(file_path: str, cls: Type[T]) -> T:
    with open(file_path, "r") as f:
        data = yaml.safe_load(f)
    return cls(**data)


# Zapisywanie konfiguracji do pliku YAML
def save_config(config: T, file_path: str):
    with open(file_path, "w") as f:
        yaml.dump(asdict(config), f)
