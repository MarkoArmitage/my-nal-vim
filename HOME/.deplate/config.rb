class Deplatejx
    def self.user_setup(options)
        if Deplate::Formatter.matches?("html")
            @@post_matter_template[9] = ["<div class='footer'>"]
            @@post_matter_template[10] = ["<p class='footer'>
                        Edited with <a href='http://www.vim.org'>Vim</a> and
                        <a href='http://www.vim.org/scripts/script.php?script_id=861'>Viki</a>,
                        created with <a href='http://deplate.sourceforge.net'>Deplate</a>.
                        Copyleft &copy; 2004 <a href='http://nic-nac-project.de/~murj/'>Rongjun Mu</a>
                        </p>"]
                        @@post_matter_template[11] = ["</div>"]
        end
        @@deplate_template << "#DOC fmt=html: css=bright.css|screen"
        @@deplate_template << "#DOC fmt=html: headings=plain"
        @@deplate_template << "#AU: NuoErlz"
        @@deplate_template << "#DATE: today"
    end
end
