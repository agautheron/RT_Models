import os
import sys

sys.path.append(os.path.abspath("./_ext"))

extensions = [
    "solution",
    "sphinxcontrib.katex",
    "sphinx_inline_tabs",
    "sphinx_math_dollar",
    "sphinx_togglebutton",
]

templates_path = ["_templates"]
exclude_patterns = ["_build"]

html_static_path = ["_static"]
html_title = "Lab Sessions"

html_theme = "furo"
html_css_files = [
    "css/style.css",
]
html_extra_path = []
html_show_sphinx = False

katex_css_path = "katex/katex.min.css"
katex_options = r"""macros: {
    "\\d": "\\operatorname{d}\\!",
    "\\dt": "\\d t",
    "\\vec": "\\overrightarrow",
}"""

import sphinx_math_dollar
replacer = sphinx_math_dollar.extension.MathDollarReplacer
replacer.visit_TabContainer = replacer.default_visit
