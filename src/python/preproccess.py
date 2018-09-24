from lxml import etree

INCLUDE_TAGS = []

def main():
    tree = etree.parse("src/TeXML_resume/resume.xml")
    root = tree.getroot()
    # print(etree.tostring(tree, pretty_print=True, encoding="unicode"))

    root = preprocess(root)
    print(etree.tostring(tree, pretty_print=True, encoding="unicode"))

def preprocess(node):
    for child in node:
        process = True
        tags = child.get("tags")
        untags = []

        if tags != None:
            tags = tags.split(",")
        else:
            tags = []

        for t in INCLUDE_TAGS:
            if t in tags:
                process = False
                node.remove(child)
                break

        if process:
            preprocess(child)

    return node

def superscipt(num_str):
    num = int(num_str)
    num_mod_10 = num % 10
    num_mod_100 = num % 100

    if num < 1:
        return None
    elif num_mod_100 >= 11 and num_mod_100 < 14:
        return "th"
    elif num_mod_10 == 1:
        return "st"
    elif num_mod_10 == 2:
        return "nd"
    elif num_mod_10 == 3:
        return "rd"
    else:
        return "th"

if __name__ == "__main__":
    main()
