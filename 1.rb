#!/user/bin/env ruby
#
#See http://blogs.agilefaqs.com/2009/07/08/refactoring-teaser-part-1/

public final class StringUtil {
  private static final Pattern REGEX_TO_SPLIT_ALONG_WHITESPACES = Pattern.compile("\\p{Z}|\\p{P}");
 
  public static String split(final String content, final int number) {
    String listOfKeywords = "";
    int count = 0;
    String[] tokens = REGEX_TO_SPLIT_ALONG_WHITESPACES.split(content);
    List<string> strings = Arrays.asList(tokens);
    List<string> allStrings = singleDoubleTripleWords(strings);
    int size = allStrings.size();
    for (String phrase : allStrings) {
      if (count == number) {
        break;
      }
      listOfKeywords += "'" + phrase + "'";
      if (++count < size && count < number) {
        listOfKeywords += ", ";
      }
    }
    return listOfKeywords;
  }
 
  private static List<String> singleDoubleTripleWords(final List<string> strings) {
    List<string> allStrings = new ArrayList<string>();
    int numWords = strings.size();
 
    if (hasEnoughWords(numWords) == false) {
      return allStrings;
    }
 
    // Extracting single words. Total size of words == numWords
 
    // Extracting single-word phrases.
    for (int i = 0; i < numWords; ++i) {
      allStrings.add(strings.get(i));
    }
 
    // Extracting double-word phrases
    for (int i = 0; i < numWords - 1; ++i) {
      allStrings.add(strings.get(i) + " " + strings.get(i + 1));
    }
 
    // Extracting triple-word phrases
    for (int i = 0; i < numWords - 2; ++i) {
      allStrings.add(strings.get(i) + " " + strings.get(i + 1) + " " + strings.get(i + 2));
    }
    return allStrings;
  }
 
  private static boolean hasEnoughWords(final int numWords) {
    if (numWords < 3) {
      return false;
    }
    return true;
  }
}

public class StringUtilTest {
  @Test
  public void testSplit() {
    assertEquals("'Hello', 'World', 'Java', 'Hello World', 'World Java', 'Hello World Java'", StringUtil.split("Hello World Java", 6));
    assertEquals("'Hello', 'World', 'Java', 'Hello World', 'World Java', 'Hello World Java'", StringUtil.split("Hello World Java", 10));
    assertEquals("'Hello', 'World', 'Java', 'Hello World'", StringUtil.split("Hello World Java", 4));
    assertEquals("'Hello'", StringUtil.split("Hello World Java", 1));
  }
}
