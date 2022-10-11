import unittest

import commands


class CommandsTestCase(unittest.TestCase):

    def test_sort_comma_separated(self):
        self.assertEqual(
            commands.sort_comma_separated("a,b,c"),
            "a,b,c",
        )
        self.assertEqual(
            commands.sort_comma_separated("c,b,a"),
            "a,b,c",
        )

    def test_sort_whitespace_separated(self):
        self.assertEqual(
            commands.sort_whitespace_separated("a b c"),
            "a b c",
        )
        self.assertEqual(
            commands.sort_whitespace_separated("c b a"),
            "a b c",
        )
