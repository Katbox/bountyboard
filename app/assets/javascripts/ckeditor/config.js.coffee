CKEDITOR.editorConfig = (config) ->
    config.toolbar = "Basic"

    # Documentation for list of potential buttons.
    # config.toolbar_Full = [
    #   name: "document"
    #   items: ["Source", "-", "Save", "NewPage", "DocProps", "Preview", "Print", "-", "Templates"]
    # ,
    #   name: "clipboard"
    #   items: ["Cut", "Copy", "Paste", "PasteText", "PasteFromWord", "-", "Undo", "Redo"]
    # ,
    #   name: "editing"
    #   items: ["Find", "Replace", "-", "SelectAll", "-", "SpellChecker", "Scayt"]
    # ,
    #   name: "forms"
    #   items: ["Form", "Checkbox", "Radio", "TextField", "Textarea", "Select", "Button", "ImageButton", "HiddenField"]
    # , "/",
    #   name: "basicstyles"
    #   items: ["Bold", "Italic", "Underline", "Strike", "Subscript", "Superscript", "-", "RemoveFormat"]
    # ,
    #   name: "paragraph"
    #   items: ["NumberedList", "BulletedList", "-", "Outdent", "Indent", "-", "Blockquote", "CreateDiv", "-", "JustifyLeft", "JustifyCenter", "JustifyRight", "JustifyBlock", "-", "BidiLtr", "BidiRtl"]
    # ,
    #   name: "links"
    #   items: ["Link", "Unlink", "Anchor"]
    # ,
    #   name: "insert"
    #   items: ["Image", "Flash", "Table", "HorizontalRule", "Smiley", "SpecialChar", "PageBreak", "Iframe"]
    # , "/",
    #   name: "styles"
    #   items: ["Styles", "Format", "Font", "FontSize"]
    # ,
    #   name: "colors"
    #   items: ["TextColor", "BGColor"]
    # ,
    #   name: "tools"
    #   items: ["Maximize", "ShowBlocks", "-", "About"]
    # ]
    config.format_tags = 'h1;h2;h3;p';
    config.toolbar_Basic = [
      name: "custom"
      items: ["Bold", "Italic", "-", "Format", "HorizontalRule", "NumberedList", "BulletedList", "-", "Link", "Unlink", "Image", "PasteFromWord", "Undo", "Redo"]
    ]
    true