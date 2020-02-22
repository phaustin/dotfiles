from pathlib import Path
homedir = Path().home()
latex_templates = str(homedir / ".jupyter/custom/latex/")
html_templates = str(homedir / ".jupyter/custom/html")
target_list = ['.', latex_templates, html_templates]
print(f"my target path list: {target_list}")
target_template = Path(html_templates) / 'newclassic2'
print(f"check for template existence: {target_template.is_dir()}")
c.TemplateExporter.template_path = target_list
from jupyter_core.paths import jupyter_path
print(f"here is my path: {jupyter_path('nbconvert','templates')}")
c.PDFExporter.latex_count = 1
c.PDFExporter.latex_command = ['latexmk', '-cd', '-lualatex', '{filename}']
