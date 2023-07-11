#!/usr/bin/python
import sys

def main() -> str:
    primary = sys.argv[1]
    monitor = sys.argv[2]

    if primary == "eDP":
        pass
    elif primary == "DP":
        pass
    else:
        return ""

if __name__ == "__main__":
    print(main())
