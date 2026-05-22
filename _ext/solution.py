import docutils.nodes
import docutils.parsers.rst

class Solution(docutils.parsers.rst.Directive):
    has_content = True
    
    def run(self):
        node = docutils.nodes.admonition(
            "\n".join(self.content), classes=["solution", "toggle"])
        node += docutils.nodes.title("Solution", "Solution")
        
        self.state.nested_parse(self.content, self.content_offset, node)
        
        return [node]

def setup(app):
    app.add_directive("solution", Solution)
    return {
        "version": "0.1",
        "parallel_read_safe": True,
        "parallel_write_safe": True,
    }
