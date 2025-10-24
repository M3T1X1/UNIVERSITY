public class BSTree {
    private TreeNode root;

    public BSTree() {
        this.root = null;
    }

    public TreeNode getRoot() {
        return this.root;
    }


    public void add(int value) {
        TreeNode newNode = new TreeNode(value);

        if (root == null) {
            root = newNode;
        } else {
            TreeNode current = root;
            TreeNode parent = null;

            while (current != null) {
                parent = current;

                if (value < current.getValue()) {
                    current = current.getLeft();
                } else if (value > current.getValue()) {
                    current = current.getRight();
                } else {
                    return;
                }
            }

            if (value < parent.getValue()) {
                parent.setLeft(newNode);
            } else {
                parent.setRight(newNode);
            }

            newNode.setParent(parent);
        }
    }

    /*
    public void remove(int value) {
        root = removeRecursive(root, value);
    }

    private TreeNode removeRecursive(TreeNode node, int value) {
        if (node == null) {
            return null;
        }

        if (value < node.getValue()) {
            node.setLeft(removeRecursive(node.getLeft(), value));
        } else if (value > node.getValue()) {
            node.setRight(removeRecursive(node.getRight(), value));
        } else {
            // No children or only one child
            if (node.getLeft() == null) {
                return node.getRight();
            }
            if (node.getRight() == null) {
                return node.getLeft();
            }

            // Two children: Replace with in-order successor
            TreeNode smallest = findMin(node.getRight());
            node.setValue(smallest.getValue());
            node.setRight(removeRecursive(node.getRight(), smallest.getValue()));
        }

        return node;
    }

    private TreeNode findMin(TreeNode node) {
        while (node.getLeft() != null) {
            node = node.getLeft();
        }
        return node;
    }

     */

    public int getMin() {
        if (root == null) {
            throw new IllegalStateException("Drzewo jest puste");
        }

        TreeNode current = root;
        while (current.getLeft() != null) {
            current = current.getLeft();
        }

        return current.getValue();
    }


    public int getHeight() {
        return getHeight(root);
    }


    private int getHeight(TreeNode node) {
        if (node == null) {
            return -1;
        }

        int leftHeight = getHeight(node.getLeft());
        int rightHeight = getHeight(node.getRight());

        return Math.max(leftHeight, rightHeight) + 1;
    }

    @Override
    public String toString() {
        return BSTreeUtils.treeToString(this);
    }

    public static void main(String[] args) {
        BSTree tree = new BSTree();
        tree.add(10);
        tree.add(5);
        tree.add(15);
        tree.add(3);
        tree.add(7);
        tree.add(12);
        tree.add(17);
        tree.add(16);
        tree.add(20);

        System.out.println(tree);
        System.out.println("Minimalna wartość w drzewie: " + tree.getMin());
        System.out.println("Wysokość drzewa: " + tree.getHeight());
    }
}
