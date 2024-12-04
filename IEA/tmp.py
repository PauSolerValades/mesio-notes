from pathlib import Path
import os

p = Path("/Users/pausolervalades/Desktop/UNIT1_IEA(1-75)_pdf/")
files = list(p.glob('*.svg'))
print(files)
for file in files:
    if file.name[9] == '(':
        new_name = f"UNIT1_IEA -{file.name.split('-')[2]}"
        new_path = file.with_name(new_name)
        print(new_name)
        os.rename(file, new_path)

