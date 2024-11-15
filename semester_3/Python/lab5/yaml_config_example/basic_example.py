import yaml
from copy import deepcopy

if __name__ == '__main__':
    config_file = "configfile.yaml"

    with open(config_file) as file:
        config_dict = yaml.safe_load(file)

    print(config_dict)
    print(config_dict['dirs']['input'])
    print(config_dict['max_file_mb'])

    modified_config_dict = deepcopy(config_dict)
    modified_config_dict['supported_formats'].append("jpeg")

    with open("./modified_config.yaml", mode="w") as file:
        yaml.dump(modified_config_dict, file)

    # # korzystanie ze słowników jest prostym sposobem,
    # # jednak bardzo szybko prowadzi do powstawania błędów
    #
    # data = {
    #     "dirs": {
    #         "input": "input/dir",
    #         "outpt": "input/dir"
    #     },
    #     "max_file_mb": 45,
    #     "suppoeted_formats": []
    # }
    #
    # with open("./different_config.yaml", "w+") as file:
    #     yaml.dump(data, file)
