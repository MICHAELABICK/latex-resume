# from sets import set
from lxml import etree

# INCLUDE_TAGS = Set([])
INCLUDE_TAGS = []

def main():
    input_file = "build/TeXML_resume/resume.xml"
    output_file = "build/TeXML_resume/resume.proc.xml"

    tree = etree.parse(input_file)
    root = tree.getroot()
    # print(etree.tostring(tree, pretty_print=True, encoding="unicode"))

    # tree = etree.ElementTree(preprocess(root))
    root = preprocess(root)
    # print(etree.tostring(tree, pretty_print=True, encoding="unicode"))
    tree.write(output_file)

def preprocess(node):
    for child in node:
        tags = child.get("tags")
        untags = child.get("untags")

        is_include = True # Assume we are going to include it
        if tags is not None or untags is not None:
            if tags != None:
                is_include = False # Unless it has a tag
                # tags = Set(tags.split(","))
                tags = tags.split(",")

                for t in INCLUDE_TAGS:
                    if t in tags:
                        is_include = True
                        break

            # If the node has already been disqualified, no need to do further checks
            if is_include and untags != None:
                # untags = Set(untags.split(","))
                untags = untags.split(",")

                for t in untags:
                    if t in INCLUDE_TAGS:
                        is_include = False
                        break

        if is_include:
            preprocess(child)
        else:
            node.remove(child)

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
