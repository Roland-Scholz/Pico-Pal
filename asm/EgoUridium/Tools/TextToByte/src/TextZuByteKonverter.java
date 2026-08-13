import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class TextZuByteKonverter {

    // Übersetzungstabelle als Map (Zeichen -> Hex-String)
    private static final Map<Character, String> ZEICHEN_MAP = new HashMap<>();

    static {
        // Zahlen
        ZEICHEN_MAP.put('0', "$00");
        ZEICHEN_MAP.put('1', "$01");
        ZEICHEN_MAP.put('2', "$02");
        ZEICHEN_MAP.put('3', "$03");
        ZEICHEN_MAP.put('4', "$04");
        ZEICHEN_MAP.put('5', "$05");
        ZEICHEN_MAP.put('6', "$06");
        ZEICHEN_MAP.put('7', "$07");
        ZEICHEN_MAP.put('8', "$08");
        ZEICHEN_MAP.put('9', "$09");

        ZEICHEN_MAP.put('I', "$16");

        ZEICHEN_MAP.put('?', "$24");
        ZEICHEN_MAP.put('!', "$25");
        ZEICHEN_MAP.put('.', "$28");
        ZEICHEN_MAP.put(',', "$29");
        ZEICHEN_MAP.put(':', "$2a");
        ZEICHEN_MAP.put('-', "$2e");
        ZEICHEN_MAP.put('=', "$2f");

        // Kleinbuchstaben
        ZEICHEN_MAP.put('a', "$0a"); ZEICHEN_MAP.put('b', "$0b"); ZEICHEN_MAP.put('c', "$0c");
        ZEICHEN_MAP.put('d', "$0d"); ZEICHEN_MAP.put('e', "$0e"); ZEICHEN_MAP.put('f', "$0f");
        ZEICHEN_MAP.put('g', "$10"); ZEICHEN_MAP.put('h', "$11"); ZEICHEN_MAP.put('i', "$12");
        ZEICHEN_MAP.put('j', "$13"); ZEICHEN_MAP.put('k', "$14"); ZEICHEN_MAP.put('l', "$15");
        /* ZEICHEN_MAP.put('m', "$16"); */ ZEICHEN_MAP.put('n', "$17"); ZEICHEN_MAP.put('o', "$18");
        ZEICHEN_MAP.put('p', "$19"); ZEICHEN_MAP.put('q', "$1a"); ZEICHEN_MAP.put('r', "$1b");
        ZEICHEN_MAP.put('s', "$1c"); ZEICHEN_MAP.put('t', "$1d"); ZEICHEN_MAP.put('u', "$1e");
        ZEICHEN_MAP.put('v', "$1f"); //ZEICHEN_MAP.put('w', "$20");
        ZEICHEN_MAP.put('x', "$21"); ZEICHEN_MAP.put('y', "$22"); ZEICHEN_MAP.put('z', "$23");

        // Leerzeichen
        ZEICHEN_MAP.put(' ', "$30");

        // Großbuchstaben
        ZEICHEN_MAP.put('A', "$3a"); ZEICHEN_MAP.put('B', "$3b"); ZEICHEN_MAP.put('C', "$3c");
        ZEICHEN_MAP.put('D', "$3d"); ZEICHEN_MAP.put('E', "$3e"); ZEICHEN_MAP.put('F', "$3f");
        ZEICHEN_MAP.put('G', "$40"); ZEICHEN_MAP.put('H', "$41"); ZEICHEN_MAP.put('m', "$42");
        ZEICHEN_MAP.put('J', "$43"); ZEICHEN_MAP.put('K', "$44"); ZEICHEN_MAP.put('L', "$45");
        ZEICHEN_MAP.put('M', "$46"); ZEICHEN_MAP.put('N', "$47"); ZEICHEN_MAP.put('O', "$48");
        ZEICHEN_MAP.put('P', "$49"); ZEICHEN_MAP.put('Q', "$4a"); ZEICHEN_MAP.put('R', "$4b");
        ZEICHEN_MAP.put('S', "$4c"); ZEICHEN_MAP.put('T', "$4d"); ZEICHEN_MAP.put('U', "$4e");
        ZEICHEN_MAP.put('V', "$4f"); ZEICHEN_MAP.put('W', "$50"); ZEICHEN_MAP.put('X', "$51");
        ZEICHEN_MAP.put('Y', "$52"); ZEICHEN_MAP.put('Z', "$53");
        ZEICHEN_MAP.put('w', "$54");
    }

    public static void main(String[] args) {
//        String eingabeDatei = "C:\\github\\uridium\\src\\game_data.asm";        // Name deiner Quelladerdatei
//       String ausgabeDatei = "C:\\github\\uridium\\src\\game_data_conv.asm";   // Name der konvertierten Zieldatei
        String eingabeDatei = "C:\\github\\uridium\\src\\level_data.asm";        // Name deiner Quelladerdatei
        String ausgabeDatei = "C:\\github\\uridium\\src\\level_data_conv.asm";   // Name der konvertierten Zieldatei

        try (BufferedReader reader = new BufferedReader(new FileReader(eingabeDatei));
             BufferedWriter writer = new BufferedWriter(new FileWriter(ausgabeDatei))) {

            String zeile;
            int zeilenNummer = 0;

            while ((zeile = reader.readLine()) != null) {
                zeilenNummer++;
                String getrimmteZeile = zeile.trim();

                // Prüfen, ob die Zeile mit .TEXT beginnt
                if (getrimmteZeile.startsWith(".TEXT")) {
                    // Finde den Teil nach ".TEXT"
                    int textIndex = zeile.indexOf(".TEXT");
                    String vorlauf = zeile.substring(0, textIndex); // Erhält eventuelle Einrückungen/Labels
                    String rest = zeile.substring(textIndex + 5).trim(); // Alles nach ".TEXT"

                    StringBuilder neueZeileElemente = new StringBuilder();
                    boolean inAnfuehrungszeichen = false;
                    StringBuilder aktuellerText = new StringBuilder();

                    // Wir gehen zeichenweise durch den Rest der Zeile
                    for (int i = 0; i < rest.length(); i++) {
                        char c = rest.charAt(i);

                        if (c == '"') {
                            if (inAnfuehrungszeichen) {
                                // Ende eines Strings erreicht -> Übersetzen
                                String uebersetzterText = uebersetzeString(aktuellerText.toString(), zeilenNummer);
                                neueZeileElemente.append(uebersetzterText);
                                aktuellerText.setLength(0); // Buffer leeren
                                inAnfuehrungszeichen = false;
                            } else {
                                // Start eines Strings
                                inAnfuehrungszeichen = true;
                            }
                        } else {
                            if (inAnfuehrungszeichen) {
                                // Zeichen gehört zum Text drinnen
                                aktuellerText.append(c);
                            } else {
                                // Zeichen ist außerhalb (z.B. Kommata, bestehende Bytes wie $7A, Leerzeichen)
                                neueZeileElemente.append(c);
                            }
                        }
                    }

                    // Falls am Zeilenende die Anführungszeichen nicht geschlossen wurden
                    if (inAnfuehrungszeichen) {
                        System.err.println("FEHLER in Zeile " + zeilenNummer +": Offenes Anführungszeichen am Zeilenende!");
                        System.exit(1);
                    }

                    // Bereinigung von doppelten oder überflüssigen Kommas, die durch leere Strings "" entstehen können
                    String bereinigterInhalt = bereinigeKommas(neueZeileElemente.toString());

                    // Baue die finale Zeile mit .BYTE
                    writer.write(vorlauf + ".BYTE " + bereinigterInhalt);
                    writer.write("\n;" + zeile);
                } else {
                    // Zeilen ohne .TEXT werden 1:1 kopiert
                    writer.write(zeile);
                }
                writer.newLine();
            }

            System.out.println("Konvertierung erfolgreich! Gespeichert unter: " + ausgabeDatei);

        } catch (IOException e) {
            System.err.println("Datei-Fehler: " + e.getMessage());
        }
    }

    // Wandelt einen String ("Hallo") in kommagetrennte Hex-Werte ($0a,$0b...) um
    private static String uebersetzeString(String text, int zeilenNummer) {
        if (text.isEmpty()) {
            return ""; // Leere Strings erzeugen keine Bytes
        }

        StringBuilder bytes = new StringBuilder();
        for (int i = 0; i < text.length(); i++) {
            char c = text.charAt(i);
            if (!ZEICHEN_MAP.containsKey(c)) {
                System.err.println("FEHLER in Zeile " + zeilenNummer + ": Zeichen '" + c + "' (ASCII: " + (int)c + ") fehlt in der Tabelle!");
                System.exit(1);
            }
            bytes.append(ZEICHEN_MAP.get(c));
            if (i < text.length() - 1) {
                bytes.append(",");
            }
        }
        return bytes.toString();
    }

    // Hilfsfunktion, um Syntax-Reste wie ", ," oder führende/folgende Kommas zu fixen
    private static String bereinigeKommas(String input) {
        // Entfernt Leerzeichen um Kommas herum für saubere Mappings
        String s = input.replaceAll("\\s*,\\s*", ",");
        // Ersetzt mehrfache Kommas (entstanden durch "") durch ein einziges Komma
        while (s.contains(",,")) {
            s = s.replace(",,", ",");
        }
        // Entfernt Kommas ganz am Anfang oder ganz am Ende des Datenblocks
        s = s.trim().replaceAll("^,", "").replaceAll(",$", "");
        // Schickes Formatieren: Setze nach jedem verbleibenden Komma ein Leerzeichen für die Lesbarkeit
        return s.replace(",", ", ");
    }
}
