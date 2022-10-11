#!/usr/bin/env python3
import argparse
import logging

logger = logging.getLogger(__name__)


def get_arguments():
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "-n",
        "--name",
        help="",
    )
    return parser.parse_args()


def main():
    logging.basicConfig(
        level=logging.INFO,
        format="%(asctime)s - %(levelname)7s - %(name)s - %(message)s",
    )
    _arguments = get_arguments()


if __name__ == "__main__":
    main()
