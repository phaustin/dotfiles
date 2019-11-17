import os
custom_path = os.path.expanduser("~/.jupyter/custom/latex")
c.TemplateExporter.template_path.append(custom_path)
c.LatexExporter.template_file = 'classic'
c.PDFExporter.latex_count = 1
c.PDFExporter.template_file = 'classic'
c.PDFExporter.latex_command = ['latexmk','-cd','-lualatex','{filename}']
