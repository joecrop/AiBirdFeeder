###################################################################################################
#
# Copyright (C) 2021 Maxim Integrated Products, Inc. All Rights Reserved.
#
# Maxim Integrated Products, Inc. Default Copyright Notice:
# https://www.maximintegrated.com/en/aboutus/legal/copyrights.html
#
###################################################################################################
"""
Parses YAML file used to define Once For All Training
"""

import yaml


def parse(yaml_file):
    """
    Parses `yaml_file` that defines the OFA policy
    """
    policy = None
    with open(yaml_file, mode='r', encoding='utf-8') as stream:
        try:
            policy = yaml.safe_load(stream)
        except yaml.YAMLError as exc:
            print(exc)

    print(policy)

    if policy and 'start_epoch' not in policy:
        assert False, '`start_epoch` must be defined in OFA policy'

    return policy
