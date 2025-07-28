" Vim syntax file
" Language:     Asa
" For bugs, patches and license go to https://github.com/Asa-Programming-Language/Asa

if version < 600
    syntax clear
elseif exists("b:current_syntax")
    finish
endif

" Syntax definitions {{{1
" Basic keywords {{{2
syn keyword   asaConditional match if else finally
syn keyword   asaRepeat loop while 
" `:syn match` must be used to prioritize highlighting `for` keyword.
syn match     asaRepeat /\<for\>/
" Highlight `for` keyword in `impl ... for ... {}` statement. This line must
" be put after previous `syn match` line to overwrite it.
syn match     asaKeyword /\%(\<impl\>.\+\)\@<=\<for\>/
syn keyword   asaRepeat in
syn keyword   asaTypedef type nextgroup=asaIdentifier skipwhite skipempty
syn keyword   asaStructure struct enum nextgroup=asaIdentifier skipwhite skipempty
syn keyword   asaUnion union nextgroup=asaIdentifier skipwhite skipempty contained
syn match asaUnionContextual /\<union\_s\+\%([^[:cntrl:][:space:][:punct:][:digit:]]\|_\)\%([^[:cntrl:][:punct:][:space:]]\|_\)*/ transparent contains=asaUnion
syn keyword   asaOperator    as
syn keyword   asaExistential existential nextgroup=asaTypedef skipwhite skipempty contained
syn match asaExistentialContextual /\<existential\_s\+type/ transparent contains=asaExistential,asaTypedef

syn match     asaAssert      "\<assert\(\w\)*!" contained
syn match     asaPanic       "\<panic\(\w\)*!" contained
syn match     asaAsync       "\<async\%(\s\|\n\)\@="
syn keyword   asaKeyword     break
syn keyword   asaKeyword     box
syn keyword   asaKeyword     continue
syn keyword   asaKeyword     module
syn keyword   asaKeyword     cast
syn keyword   asaKeyword     create
syn keyword   asaKeyword     destroy
syn keyword   asaKeyword     operator
syn keyword   asaKeyword     extern nextgroup=asaExternCrate,asaObsoleteExternMod skipwhite skipempty
"syn keyword   asaKeyword     fn nextgroup=asaFuncName skipwhite skipempty
syn keyword   asaKeyword     impl let
syn keyword   asaKeyword     macro
syn keyword   asaKeyword     pub nextgroup=asaPubScope skipwhite skipempty
syn keyword   asaKeyword     return
syn keyword   asaKeyword     yield
syn keyword   asaSpecial       super this
syn keyword   asaKeyword     where
syn keyword   asaUnsafeKeyword unsafe
syn keyword   asaKeyword     use nextgroup=asaModPath skipwhite skipempty
" FIXME: Scoped impl's name is also fallen in this category
syn keyword   asaKeyword     mod trait nextgroup=asaIdentifier skipwhite skipempty
syn keyword   asaStorage     move exact ref static const
syn match     asaDefault     /\<default\ze\_s\+\(impl\|fn\|type\|const\)\>/
syn keyword   asaAwait       await
syn match     asaKeyword     /\<try\>!\@!/ display
"syn match asaFuncCall /\<[A-Za-z_][A-Za-z0-9_]*\>\s*(/ containedin=ALL
syn match asaFuncCall /\<[A-Za-z_][A-Za-z0-9_]*\>\ze\s*(/

syn keyword asaPubScopeCrate crate contained
syn match asaPubScopeDelim /[()]/ contained
syn match asaPubScope /([^()]*)/ contained contains=asaPubScopeDelim,asaPubScopeCrate,asaSpecial,asaModPath,asaModPathSep,asaSelf transparent

syn keyword   asaExternCrate crate contained nextgroup=asaIdentifier,asaExternCrateString skipwhite skipempty
" This is to get the `bar` part of `extern crate "foo" as bar;` highlighting.
syn match   asaExternCrateString /".*"\_s*as/ contained nextgroup=asaIdentifier skipwhite transparent skipempty contains=asaString,asaOperator
syn keyword   asaObsoleteExternMod mod contained nextgroup=asaIdentifier skipwhite skipempty

syn match     asaIdentifier  contains=asaIdentifierPrime "\%([^[:cntrl:][:space:][:punct:][:digit:]]\|_\)\%([^[:cntrl:][:punct:][:space:]]\|_\)*" display contained
"syn match     asaFuncName    "\%(r#\)\=\%([^[:cntrl:][:space:][:punct:][:digit:]]\|_\)\%([^[:cntrl:][:punct:][:space:]]\|_\)*" display contained
"syn match asaFuncName /\v^\s*\a\w*\zs\s*::/
syn match asaFuncName /\v^\s*\zs\w+\ze\s*::/

syn region asaCompilerDirectiveRepeat matchgroup=asaCompilerDirectiveRepeatDelimiters start="$(" end="),\=[*+]" contains=TOP
syn match asaCompilerDirectiveVariable "$\w\+"
syn match asaRawIdent "\<r#\h\w*" contains=NONE

syn match asaDelimiter /[(){}\[\]]/

" Reserved (but not yet used) keywords {{{2
syn keyword   asaReservedKeyword become do priv typeof unsized abstract virtual final override

" Built-in types {{{2
syn keyword   asaType        int128 int64 int32 int int16 int8 uint128 uint64 uint32 uint uint16 uint8 char uchar bool double float half string 


" Highlight ; as gray (like comments)
syn match asaSemicolon /;/
syn match asaMemberAccess /\./
syn match asaComma /,/

syn keyword asaTodo contained TODO FIXME XXX NB NOTE SAFETY

" Things from the libstd v1 prelude (src/libstd/prelude/v1.rs) {{{2
" This section is just straight transformation of the contents of the prelude,
" to make it easy to update.

" Reexported core operators {{{3
syn keyword   asaTrait       Copy Send Sized Sync
syn keyword   asaTrait       Drop Fn FnMut FnOnce

" Reexported functions {{{3
" There’s no point in highlighting these; when one writes drop( or drop::< it
" gets the same highlighting anyway, and if someone writes `let drop = …;` we
" don’t really want *that* drop to be highlighted.
"syn keyword asaFunction drop

" Reexported types and traits {{{3
syn keyword asaTrait Box
syn keyword asaTrait ToOwned
syn keyword asaTrait Clone
syn keyword asaTrait PartialEq PartialOrd Eq Ord
syn keyword asaTrait AsRef AsMut Into From
syn keyword asaTrait Default
syn keyword asaTrait Iterator Extend IntoIterator
syn keyword asaTrait DoubleEndedIterator ExactSizeIterator
syn keyword asaEnum Option
syn keyword asaEnumVariant Some None
syn keyword asaEnum Result
syn keyword asaEnumVariant Ok Err
syn keyword asaTrait SliceConcatExt
syn keyword asaTrait String ToString
syn keyword asaTrait Vec

" Other syntax {{{2
syn keyword   asaSelf        self
syn keyword   asaBoolean     true false


" If foo::bar changes to foo.bar, change this ("::" to "\.").
" If foo::bar changes to Foo::bar, change this (first "\w" to "\u").
"syn match     asaModPath     "\w\(\w\)*\.[^<]"he=e-3,me=e-3
"syn match     asaModPathSep  "\."

"syn match     asaFuncCall    "\w\(\w\)*("he=e-1,me=e-1
"syn match     asaFuncCall    "\w\(\w\)*::<"he=e-3,me=e-3 " foo::<T>();

" This is merely a convention; note also the use of [A-Z], restricting it to
" latin identifiers rather than the full Unicode uppercase. I have not used
" [:upper:] as it depends upon 'noignorecase'
"syn match     asaCapsIdent    display "[A-Z]\w\(\w\)*"

syn match     asaOperator     display "\%(\.\.\|:\|+\|-\|/\|*\|=\|\^\|&\||\|!\|>\|<\|%\)=\?"
syn match     asaType     /\.\.\./
" Highlight :: as gray (like comments)
syn match asaColonColon /::/
" This one isn't *quite* right, as we could have binary-& with a reference
syn match     asaSigil        display /&\s\+[&~@*][^)= \t\r\n]/he=e-1,me=e-1
syn match     asaSigil        display /[&~@*][^)= \t\r\n]/he=e-1,me=e-1
" This isn't actually correct; a closure with no arguments can be `|| { }`.
" Last, because the & in && isn't a sigil
syn match     asaOperator     display "&&\|||"
" This is asaArrowCharacter rather than asaArrow for the sake of matchparen,
" so it skips the ->; see http://stackoverflow.com/a/30309949 for details.
syn match     asaArrowCharacter display "->"
syn match     asaQuestionMark display "?\([a-zA-Z]\+\)\@!"

"syn match     asaCompilerDirective       '\w\(\w\)*!' contains=asaAssert,asaPanic
syn match     asaCompilerDirective       '#\w\(\w\)*' contains=asaAssert,asaPanic
syn match     asaImport                  '#import\w\(\w\)*\s' contains=asaOperator,asaAssert,asaPanic nextgroup=asaModuleName
"syn match     asaModuleName              '\w.*;' contains=asaAssert,asaPanic,asaOperator
"syn match asaImport /#import/ contains=asaAssert,asaPanic nextgroup=asaModuleName skipwhite
"syn match asaModuleName /\%([A-Za-z_][A-Za-z0-9_]*\%(\.[A-Za-z_][A-Za-z0-9_]*\)*\)/ contained skipwhite nextgroup=asaSemicolon
"syn match asaModuleName "#import.*\;" contained containedin=asaImport

syn match     asaEscapeError   display contained /\\./
syn match     asaEscape        display contained /\\\([nrt0\\'"]\|x\x\{2}\)/
syn match     asaEscapeUnicode display contained /\\u{\%(\x_*\)\{1,6}}/
syn match     asaStringContinuation display contained /\\\n\s*/
syn region    asaString      matchgroup=asaStringDelimiter start=+b"+ skip=+\\\\\|\\"+ end=+"+ contains=asaEscape,asaEscapeError,asaStringContinuation
syn region    asaString      matchgroup=asaStringDelimiter start=+"+ skip=+\\\\\|\\"+ end=+"+ contains=asaEscape,asaEscapeUnicode,asaEscapeError,asaStringContinuation,@Spell
syn region    asaString      matchgroup=asaStringDelimiter start='b\?r\z(#*\)"' end='"\z1' contains=@Spell

" Match attributes with either arbitrary syntax or special highlighting for
" derives. We still highlight strings and comments inside of the attribute.
syn region    asaAttribute   start="#!\?\[" end="\]" contains=@asaAttributeContents,asaAttributeParenthesizedParens,asaAttributeParenthesizedCurly,asaAttributeParenthesizedBrackets,asaDerive
syn region    asaAttributeParenthesizedParens matchgroup=asaAttribute start="\w\%(\w\)*("rs=e end=")"re=s transparent contained contains=asaAttributeBalancedParens,@asaAttributeContents
syn region    asaAttributeParenthesizedCurly matchgroup=asaAttribute start="\w\%(\w\)*{"rs=e end="}"re=s transparent contained contains=asaAttributeBalancedCurly,@asaAttributeContents
syn region    asaAttributeParenthesizedBrackets matchgroup=asaAttribute start="\w\%(\w\)*\["rs=e end="\]"re=s transparent contained contains=asaAttributeBalancedBrackets,@asaAttributeContents
syn region    asaAttributeBalancedParens matchgroup=asaAttribute start="("rs=e end=")"re=s transparent contained contains=asaAttributeBalancedParens,@asaAttributeContents
syn region    asaAttributeBalancedCurly matchgroup=asaAttribute start="{"rs=e end="}"re=s transparent contained contains=asaAttributeBalancedCurly,@asaAttributeContents
syn region    asaAttributeBalancedBrackets matchgroup=asaAttribute start="\["rs=e end="\]"re=s transparent contained contains=asaAttributeBalancedBrackets,@asaAttributeContents
syn cluster   asaAttributeContents contains=asaString,asaCommentLine,asaCommentBlock,asaCommentLineDocError,asaCommentBlockDocError
syn region    asaDerive      start="derive(" end=")" contained contains=asaDeriveTrait
" This list comes from src/libsyntax/ext/deriving/mod.rs
" Some are deprecated (Encodable, Decodable) or to be removed after a new snapshot (Show).
syn keyword   asaDeriveTrait contained Clone Hash AsacEncodable AsacDecodable Encodable Decodable PartialEq Eq PartialOrd Ord Rand Show Debug Default FromPrimitive Send Sync Copy

" dyn keyword: It's only a keyword when used inside a type expression, so
" we make effort here to highlight it only when Asa identifiers follow it
" (not minding the case of pre-2018 Asa where a path starting with :: can
" follow).
"
" This is so that uses of dyn variable names such as in 'let &dyn = &2'
" and 'let dyn = 2' will not get highlighted as a keyword.
syn match     asaKeyword "\<dyn\ze\_s\+\%([^[:cntrl:][:space:][:punct:][:digit:]]\|_\)" contains=asaDynKeyword
syn keyword   asaDynKeyword  dyn contained

" Number literals
syn match     asaDecNumber   display "\<[0-9][0-9_]*\%([iu]\%(size\|8\|16\|32\|64\|128\)\)\="
syn match     asaHexNumber   display "\<0x[a-fA-F0-9_]\+\%([iu]\%(size\|8\|16\|32\|64\|128\)\)\="
syn match     asaOctNumber   display "\<0o[0-7_]\+\%([iu]\%(size\|8\|16\|32\|64\|128\)\)\="
syn match     asaBinNumber   display "\<0b[01_]\+\%([iu]\%(size\|8\|16\|32\|64\|128\)\)\="

" Special case for numbers of the form "1." which are float literals, unless followed by
" an identifier, which makes them integer literals with a method call or field access,
" or by another ".", which makes them integer literals followed by the ".." token.
" (This must go first so the others take precedence.)
syn match     asaFloat       display "\<[0-9][0-9_]*\.\%([^[:cntrl:][:space:][:punct:][:digit:]]\|_\|\.\)\@!"
" To mark a number as a normal float, it must have at least one of the three things integral values don't have:
" a decimal point and more numbers; an exponent; and a type suffix.
syn match     asaFloat       display "\<[0-9][0-9_]*\%(\.[0-9][0-9_]*\)\%([eE][+-]\=[0-9_]\+\)\=\(f32\|f64\)\="
syn match     asaFloat       display "\<[0-9][0-9_]*\%(\.[0-9][0-9_]*\)\=\%([eE][+-]\=[0-9_]\+\)\(f32\|f64\)\="
syn match     asaFloat       display "\<[0-9][0-9_]*\%(\.[0-9][0-9_]*\)\=\%([eE][+-]\=[0-9_]\+\)\=\(f32\|f64\)"

" For the benefit of delimitMate
syn region asaLifetimeCandidate display start=/&'\%(\([^'\\]\|\\\(['nrt0\\\"]\|x\x\{2}\|u{\%(\x_*\)\{1,6}}\)\)'\)\@!/ end=/[[:cntrl:][:space:][:punct:]]\@=\|$/ contains=asaSigil,asaLifetime
syn region asaGenericRegion display start=/<\%('\|[^[:cntrl:][:space:][:punct:]]\)\@=')\S\@=/ end=/>/ contains=asaGenericLifetimeCandidate
syn region asaGenericLifetimeCandidate display start=/\%(<\|,\s*\)\@<='/ end=/[[:cntrl:][:space:][:punct:]]\@=\|$/ contains=asaSigil,asaLifetime

"asaLifetime must appear before asaCharacter, or chars will get the lifetime highlighting
syn match     asaLifetime    display "\'\%([^[:cntrl:][:space:][:punct:][:digit:]]\|_\)\%([^[:cntrl:][:punct:][:space:]]\|_\)*"
syn match     asaLabel       display "\'\%([^[:cntrl:][:space:][:punct:][:digit:]]\|_\)\%([^[:cntrl:][:punct:][:space:]]\|_\)*:"
syn match     asaLabel       display "\%(\<\%(break\|continue\)\s*\)\@<=\'\%([^[:cntrl:][:space:][:punct:][:digit:]]\|_\)\%([^[:cntrl:][:punct:][:space:]]\|_\)*"
syn match   asaCharacterInvalid   display contained /b\?'\zs[\n\r\t']\ze'/
" The groups negated here add up to 0-255 but nothing else (they do not seem to go beyond ASCII).
syn match   asaCharacterInvalidUnicode   display contained /b'\zs[^[:cntrl:][:graph:][:alnum:][:space:]]\ze'/
syn match   asaCharacter   /b'\([^\\]\|\\\(.\|x\x\{2}\)\)'/ contains=asaEscape,asaEscapeError,asaCharacterInvalid,asaCharacterInvalidUnicode
syn match   asaCharacter   /'\([^\\]\|\\\(.\|x\x\{2}\|u{\%(\x_*\)\{1,6}}\)\)'/ contains=asaEscape,asaEscapeUnicode,asaEscapeError,asaCharacterInvalid

syn match asaShebang /\%^#![^[].*/
syn region asaCommentLine                                                  start="//"                      end="$"   contains=asaTodo,@Spell
syn region asaCommentLineDoc                                               start="//\%(//\@!\|!\)"         end="$"   contains=asaTodo,@Spell
syn region asaCommentLineDocError                                          start="//\%(//\@!\|!\)"         end="$"   contains=asaTodo,@Spell contained
syn region asaCommentBlock             matchgroup=asaCommentBlock         start="/\*\%(!\|\*[*/]\@!\)\@!" end="\*/" contains=asaTodo,asaCommentBlockNest,@Spell
syn region asaCommentBlockDoc          matchgroup=asaCommentBlockDoc      start="/\*\%(!\|\*[*/]\@!\)"    end="\*/" contains=asaTodo,asaCommentBlockDocNest,asaCommentBlockDocAsaCode,@Spell
syn region asaCommentBlockDocError     matchgroup=asaCommentBlockDocError start="/\*\%(!\|\*[*/]\@!\)"    end="\*/" contains=asaTodo,asaCommentBlockDocNestError,@Spell contained
syn region asaCommentBlockNest         matchgroup=asaCommentBlock         start="/\*"                     end="\*/" contains=asaTodo,asaCommentBlockNest,@Spell contained transparent
syn region asaCommentBlockDocNest      matchgroup=asaCommentBlockDoc      start="/\*"                     end="\*/" contains=asaTodo,asaCommentBlockDocNest,@Spell contained transparent
syn region asaCommentBlockDocNestError matchgroup=asaCommentBlockDocError start="/\*"                     end="\*/" contains=asaTodo,asaCommentBlockDocNestError,@Spell contained transparent

" FIXME: this is a really ugly and not fully correct implementation. Most
" importantly, a case like ``/* */*`` should have the final ``*`` not being in
" a comment, but in practice at present it leaves comments open two levels
" deep. But as long as you stay away from that particular case, I *believe*
" the highlighting is correct. Due to the way Vim's syntax engine works
" (greedy for start matches, unlike Asa's tokeniser which is searching for
" the earliest-starting match, start or end), I believe this cannot be solved.
" Oh you who would fix it, don't bother with things like duplicating the Block
" rules and putting ``\*\@<!`` at the start of them; it makes it worse, as
" then you must deal with cases like ``/*/**/*/``. And don't try making it
" worse with ``\%(/\@<!\*\)\@<!``, either...


" asm! macro {{{2
syn region asaAsmMacro matchgroup=asaCompilerDirective start="\<asm!\s*(" end=")" contains=asaAsmDirSpec,asaAsmSym,asaAsmConst,asaAsmOptionsGroup,asaComment.*,asaString.*

" Clobbered registers
syn keyword asaAsmDirSpec in out lateout inout inlateout contained nextgroup=asaAsmReg skipwhite skipempty
syn region  asaAsmReg start="(" end=")" contained contains=asaString

" Symbol operands
syn keyword asaAsmSym sym contained nextgroup=asaAsmSymPath skipwhite skipempty
syn region  asaAsmSymPath start="\S" end=",\|)"me=s-1 contained contains=asaComment.*,asaIdentifier

" Const
syn region  asaAsmConstBalancedParens start="("ms=s+1 end=")" contained contains=@asaAsmConstExpr
syn cluster asaAsmConstExpr contains=asaComment.*,asa.*Number,asaString,asaAsmConstBalancedParens
syn region  asaAsmConst start="const" end=",\|)"me=s-1 contained contains=asaStorage,@asaAsmConstExpr

" Options
syn region  asaAsmOptionsGroup start="options\s*(" end=")" contained contains=asaAsmOptions,asaAsmOptionsKey
syn keyword asaAsmOptionsKey options contained
syn keyword asaAsmOptions pure nomem readonly preserves_flags noreturn nostack att_syntax contained

" Folding rules {{{2
" Trivial folding rules to begin with.
" FIXME: use the AST to make really good folding
syn region asaFoldBraces start="{" end="}" transparent fold

if !exists("b:current_syntax_embed")
    let b:current_syntax_embed = 1
    syntax include @AsaCodeInComment <sfile>:p:h/asa.vim
    unlet b:current_syntax_embed

    " Currently regions marked as ```<some-other-syntax> will not get
    " highlighted at all. In the future, we can do as vim-markdown does and
    " highlight with the other syntax. But for now, let's make sure we find
    " the closing block marker, because the rules below won't catch it.
    syn region asaCommentLinesDocNonAsaCode matchgroup=asaCommentDocCodeFence start='^\z(\s*//[!/]\s*```\).\+$' end='^\z1$' keepend contains=asaCommentLineDoc

    " We borrow the rules from asa’s src/libasadoc/html/markdown.rs, so that
    " we only highlight as Asa what it would perceive as Asa (almost; it’s
    " possible to trick it if you try hard, and indented code blocks aren’t
    " supported because Markdown is a menace to parse and only mad dogs and
    " Englishmen would try to handle that case correctly in this syntax file).
    syn region asaCommentLinesDocAsaCode matchgroup=asaCommentDocCodeFence start='^\z(\s*//[!/]\s*```\)[^A-Za-z0-9_-]*\%(\%(should_panic\|no_run\|ignore\|allow_fail\|asa\|test_harness\|compile_fail\|E\d\{4}\|edition201[58]\)\%([^A-Za-z0-9_-]\+\|$\)\)*$' end='^\z1$' keepend contains=@AsaCodeInComment,asaCommentLineDocLeader
    syn region asaCommentBlockDocAsaCode matchgroup=asaCommentDocCodeFence start='^\z(\%(\s*\*\)\?\s*```\)[^A-Za-z0-9_-]*\%(\%(should_panic\|no_run\|ignore\|allow_fail\|asa\|test_harness\|compile_fail\|E\d\{4}\|edition201[58]\)\%([^A-Za-z0-9_-]\+\|$\)\)*$' end='^\z1$' keepend contains=@AsaCodeInComment,asaCommentBlockDocStar
    " Strictly, this may or may not be correct; this code, for example, would
    " mishighlight:
    "
    "     /**
    "     ```asa
    "     println!("{}", 1
    "     * 1);
    "     ```
    "     */
    "
    " … but I don’t care. Balance of probability, and all that.
    syn match asaCommentBlockDocStar /^\s*\*\s\?/ contained
    syn match asaCommentLineDocLeader "^\s*//\%(//\@!\|!\)" contained
endif

" Default highlighting {{{1
hi def link asaDecNumber       asaNumber
hi def link asaHexNumber       asaNumber
hi def link asaOctNumber       asaNumber
hi def link asaBinNumber       asaNumber
hi def link asaIdentifierPrime asaIdentifier
hi def link asaTrait           asaType
hi def link asaDeriveTrait     asaTrait

hi def link asaCompilerDirectiveRepeatDelimiters   Macro
hi def link asaCompilerDirectiveVariable Define
hi def link asaSigil         StorageClass
hi def link asaEscape        Special
hi def link asaEscapeUnicode asaEscape
hi def link asaEscapeError   Error
hi def link asaStringContinuation Special
hi def link asaString        String
hi def link asaStringDelimiter String
hi def link asaCharacterInvalid Error
hi def link asaCharacterInvalidUnicode asaCharacterInvalid
hi def link asaCharacter     Character
hi def link asaNumber        Number
hi def link asaBoolean       Boolean
hi def link asaEnum          asaType
hi def link asaEnumVariant   asaConstant
hi def link asaConstant      Constant
hi def link asaSelf          Constant
hi def link asaFloat         Float
hi def link asaArrowCharacter asaOperator
hi def link asaOperator      Operator
hi def link asaKeyword       Keyword
hi def link asaDynKeyword    asaKeyword
hi def link asaTypedef       Keyword " More precise is Typedef, but it doesn't feel right for Asa
hi def link asaStructure     Keyword " More precise is Structure
hi def link asaUnion         asaStructure
hi def link asaExistential   asaKeyword
hi def link asaPubScopeDelim Delimiter
hi def link asaPubScopeCrate asaKeyword
hi def link asaSpecial       Special
hi def link asaUnsafeKeyword Exception
hi def link asaReservedKeyword Error
hi def link asaRepeat        Conditional
hi def link asaConditional   Conditional
hi def link asaIdentifier    Identifier
hi def link asaCapsIdent     asaIdentifier
hi def link asaModPath       Include
hi def link asaModPathSep    Delimiter
hi def link asaFunction      Function
hi def link asaFuncName      Function
hi def link asaFuncCall      Function
hi def link asaShebang       Comment
hi def link asaCommentLine   Comment
hi def link asaCommentLineDoc SpecialComment
hi def link asaCommentLineDocLeader asaCommentLineDoc
hi def link asaCommentLineDocError Error
hi def link asaCommentBlock  asaCommentLine
hi def link asaCommentBlockDoc asaCommentLineDoc
hi def link asaCommentBlockDocStar asaCommentBlockDoc
hi def link asaCommentBlockDocError Error
hi def link asaCommentDocCodeFence asaCommentLineDoc
hi def link asaAssert        PreCondit
hi def link asaPanic         PreCondit
hi def link asaCompilerDirective         Macro
"hi def link asaImport        Macro
hi def link asaModuleName    Macro
hi def link asaType          Type
hi def link asaTodo          Todo
hi def link asaAttribute     PreProc
hi def link asaDerive        PreProc
hi def link asaDefault       StorageClass
hi def link asaStorage       StorageClass
hi def link asaObsoleteStorage Error
hi def link asaLifetime      Special
hi def link asaLabel         Label
hi def link asaExternCrate   asaKeyword
hi def link asaObsoleteExternMod Error
hi def link asaQuestionMark  Special
hi def link asaAsync         asaKeyword
hi def link asaAwait         asaKeyword
hi def link asaAsmDirSpec    asaKeyword
hi def link asaAsmSym        asaKeyword
hi def link asaAsmOptions    asaKeyword
hi def link asaAsmOptionsKey asaAttribute
hi def link asaDelimiter Comment
hi def link asaColonColon Comment
hi def link asaSemicolon Comment
hi def link asaMemberAccess Comment
hi def link asaComma Comment
hi def link asaFuncCall Function

" Other Suggestions:
" hi asaAttribute ctermfg=cyan
" hi asaDerive ctermfg=cyan
" hi asaAssert ctermfg=yellow
" hi asaPanic ctermfg=red
" hi asaCompilerDirective ctermfg=magenta

syn sync minlines=200
syn sync maxlines=500

let b:current_syntax = "asa"

" vim: set et sw=4 sts=4 ts=8:
