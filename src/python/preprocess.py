from lxml import etree

INCLUDE_TAGS = set([])

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
    add_superscript(node)

    for child in node:
        tags = child.get("tags")
        untags = child.get("untags")

        is_include = True # Assume we are going to include it
        if tags is not None or untags is not None:
            if tags != None:
                is_include = False # Unless it has a tag
                tags = set(tags.split(","))

                for t in INCLUDE_TAGS:
                    if t in tags:
                        is_include = True
                        break

            # If the node has already been disqualified, no need to do further checks
            if is_include and untags != None:
                untags = set(untags.split(","))

                for t in untags:
                    if t in INCLUDE_TAGS:
                        is_include = False
                        break

        if is_include:
            preprocess(child)
        else:
            node.remove(child)

    return node

def add_superscript(node):
    for child in node:
        if child.tag == "supernum":
            child_num = child.text
            child_superscript = superscript(child_num)

            # Combine with text or tail depending on child position
            ind = node.index(child)
            if ind == 0:
                node.text = xstr(node.text) + child_num
            else:
                node[ind - 1].tail = xstr(node[ind - 1].tail) + child_num

            child.tag = "super"
            child.text = child_superscript


def superscript(num_str):
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

def xstr(s):
    if s is None:
        return ""
    return str(s)

if __name__ == "__main__":
    main()
