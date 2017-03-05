# autoparen2

Automatic `)`, `]`, `}` typing when their open counterpart is typed by user.
When user is typing them manually which is the same as the character right to the text caret, the typing is replaced with moving to the right one character.

Another thing it does happens when you insert a newline right after inserting a pair of braces, namely `{}`, between them. What it does is inserting another newline before `}` and moving back to the blank line between the braces keeping the indent.
