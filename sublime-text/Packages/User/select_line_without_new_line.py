import sublime, sublime_plugin, re

class SelectLineWithoutNewLineCommand(sublime_plugin.TextCommand):
    def run(self, edit):
        beginCaretPos = self.view.sel()[0].begin()
        endCaretPos = self.view.sel()[-1].end()
        beginOfLine = self.view.line(beginCaretPos).begin()
        endOfLine = self.view.line(endCaretPos).end()
        self.view.sel().add(sublime.Region(beginOfLine, endOfLine))
