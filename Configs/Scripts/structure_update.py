import re, subprocess

tree = subprocess.check_output(
    ["tree", "-a", "--dirsfirst", "--noreport", "-I", ".git", "Configs/"],
    text=True
)
block = f"<!-- TREE_START -->\n```\n{tree}```\n<!-- TREE_END -->"
readme = open("README.md").read()
updated = re.sub(r"<!-- TREE_START -->.*?<!-- TREE_END -->", block, readme, flags=re.DOTALL)
open("README.md", "w").write(updated)
